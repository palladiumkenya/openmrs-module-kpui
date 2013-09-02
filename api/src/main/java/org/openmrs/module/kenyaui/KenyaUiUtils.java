/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */

package org.openmrs.module.kenyaui;

import org.apache.commons.lang3.BooleanUtils;
import org.joda.time.Period;
import org.joda.time.PeriodType;
import org.ocpsoft.prettytime.PrettyTime;
import org.openmrs.Concept;
import org.openmrs.Person;
import org.openmrs.PersonName;
import org.openmrs.api.context.Context;
import org.openmrs.module.appframework.AppDescriptor;
import org.openmrs.ui.framework.fragment.FragmentActionRequest;
import org.openmrs.ui.framework.page.PageRequest;
import org.openmrs.util.OpenmrsUtil;
import org.openmrs.web.WebConstants;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * UI utility methods
 */
@Component
public class KenyaUiUtils {

	private static final DateFormat dateFormatter = new SimpleDateFormat(KenyaUiConstants.DATE_FORMAT);

	private static final DateFormat timeFormatter = new SimpleDateFormat(KenyaUiConstants.TIME_FORMAT);

	/**
	 * Sets the notification success message
	 * @param session the session
	 * @param message the message
	 */
	public void notifySuccess(HttpSession session, String message) {
		session.setAttribute(WebConstants.OPENMRS_MSG_ATTR, message);
	}

	/**
	 * Sets the notification error message
	 * @param session the session
	 * @param message the message
	 */
	public void notifyError(HttpSession session, String message) {
		session.setAttribute(WebConstants.OPENMRS_ERROR_ATTR, message);
	}

	/**
	 * Formats a date time
	 * @param date the date
	 * @return the string value
	 */
	public String formatDateTime(Date date) {
		if (date == null) {
			return "";
		}

		return dateFormatter.format(date) + " " + timeFormatter.format(date);
	}

	/**
	 * Formats a date ignoring any time information
	 * @param date the date
	 * @return the string value
	 * @should format date as a string without time information
	 * @should format null date as empty string
	 */
	public String formatDate(Date date) {
		if (date == null) {
			return "";
		}

		return dateFormatter.format(date);
	}

	/**
	 * Formats a date as a time value only
	 * @param date the date
	 * @return the string value
	 * @should format date as a string without time information
	 * @should format null date as empty string
	 */
	public String formatTime(Date date) {
		if (date == null) {
			return "";
		}

		return timeFormatter.format(date);
	}

	/**
	 * Formats a date interval relative to now
	 * @param date the date relative to now
	 * @return the formatted interval
	 */
	public String formatInterval(Date date) {
		return formatInterval(date, new Date());
	}

	/**
	 * Formats a date interval relative to the given date
	 * @param date the date relative to the given now
	 * @param now the given now
	 * @return the formatted interval
	 */
	public String formatInterval(Date date, Date now) {
		PrettyTime t = new PrettyTime(now);
		return t.format(date);
	}

	/**
	 * Formats a person's name
	 * @param person the person
	 * @return the string value
	 * @should format voided person as empty string
	 */
	public String formatPersonName(Person person) {
		PersonName name = person.getPersonName();
		if (name != null) {
			List<String> items = new ArrayList<String>();

			if (name.getFamilyName() != null) {
				items.add(name.getFamilyName() + ",");
			}
			if (name.getGivenName() != null) {
				items.add(name.getGivenName());
			}
			if (name.getMiddleName() != null) {
				items.add(name.getMiddleName());
			}
			return OpenmrsUtil.join(items, " ");
		}
		return "";
	}

	/**
	 * Formats a person's age
	 * @param person the person
	 * @return the string value
	 */
	public String formatPersonAge(Person person) {
		String prefix = BooleanUtils.isTrue(person.isBirthdateEstimated()) ? "~" : "";
		int ageYears = person.getAge();

		if (ageYears < 1) {
			Period p = new Period(person.getBirthdate().getTime(), System.currentTimeMillis(), PeriodType.yearMonthDay());
			return prefix + p.getMonths() + " month(s), " + p.getDays() + " day(s)";
		}
		else {
			return prefix + ageYears + " year(s)";
		}
	}

	/**
	 * Formats a person's birth date
	 * @param person the person
	 * @return the string value
	 */
	public String formatPersonBirthdate(Person person) {
		return (BooleanUtils.isTrue(person.isBirthdateEstimated()) ? "approx " : "") + formatDate(person.getBirthdate());
	}

	/**
	 * Gets a concept by an identifier (id, mapping or UUID)
	 * @param identifier the identifier
	 * @return the concept
	 * @throws RuntimeException if no concept could be found
	 */
	public static Concept getConcept(Object identifier) {
		Concept concept = null;

		if (identifier instanceof Integer) {
			concept = Context.getConceptService().getConcept((Integer) identifier);
		}
		else if (identifier instanceof String) {
			String str = (String) identifier;

			if (str.contains(":")) {
				String[] tokens = str.split(":");
				concept = Context.getConceptService().getConceptByMapping(tokens[1].trim(), tokens[0].trim());
			}
			else {
				// Assume its a UUID
				concept = Context.getConceptService().getConceptByUuid(str);
			}
		}

		if (concept == null) {
			throw new IllegalArgumentException("No concept with identifier '" + identifier + "'");
		}

		return concept;
	}

	/**
	 * Fetches a list of concepts from a collection of concepts, concept ids, concept mappings or concept UUIDs
	 * @param references the collection of concepts, concept ids, concept mappings or concept UUIDs
	 * @return the list of concepts
	 * @throws IllegalArgumentException if item in list is not a concept, and Integer or a String
	 * @throws NumberFormatException if a String identifier is not a valid integer
	 * @should fetch from concepts, integers or strings
	 * @should throw exception for non concepts, integers or strings
	 */
	public List<Concept> fetchConcepts(Collection<?> references) {
		List<Concept> concepts = new ArrayList<Concept>();
		for (Object o : references) {
			if (o instanceof Concept) {
				concepts.add((Concept) o);
			}
			else {
				concepts.add(getConcept(o));
			}
		}
		return concepts;
	}

	/**
	 * Convenience method to get the current app for the request
	 * @param request the page request
	 * @return the app descriptor
	 */
	public AppDescriptor getCurrentApp(PageRequest request) {
		return (AppDescriptor) request.getRequest().getAttribute(KenyaUiConstants.REQUEST_ATTR_CURRENT_APP);
	}

	/**
	 * Convenience method to get the current app for the request
	 * @param request the fragment action request
	 * @return the app descriptor
	 */
	public AppDescriptor getCurrentApp(FragmentActionRequest request) {
		return (AppDescriptor) request.getHttpRequest().getAttribute(KenyaUiConstants.REQUEST_ATTR_CURRENT_APP);
	}
}