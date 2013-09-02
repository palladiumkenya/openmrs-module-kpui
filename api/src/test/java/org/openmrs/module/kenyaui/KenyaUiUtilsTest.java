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

import org.apache.commons.lang.StringUtils;
import org.junit.Assert;
import org.junit.Test;
import org.openmrs.Concept;
import org.openmrs.Person;
import org.openmrs.PersonName;
import org.openmrs.api.context.Context;
import org.openmrs.module.kenyaui.test.TestUtils;
import org.openmrs.test.BaseModuleContextSensitiveTest;
import org.openmrs.web.WebConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpSession;

import java.util.*;

import static org.hamcrest.Matchers.*;

/**
 * Test for {@link KenyaUiUtils}
 */
public class KenyaUiUtilsTest extends BaseModuleContextSensitiveTest {

	@Autowired
	private KenyaUiUtils kenyaUi;

	@Test
	public void notifySuccess_shouldSetMessageSessionAttribute() {
		MockHttpSession session = new MockHttpSession();
		kenyaUi.notifySuccess(session, "test");

		Assert.assertThat((String) session.getAttribute(WebConstants.OPENMRS_MSG_ATTR), is("test"));
	}

	@Test
	public void notifySuccess_shouldSetErrorSessionAttribute() {
		MockHttpSession session = new MockHttpSession();
		kenyaUi.notifyError(session, "test");

		Assert.assertThat((String) session.getAttribute(WebConstants.OPENMRS_ERROR_ATTR), is("test"));
	}

	/**
	 * @see org.openmrs.module.kenyaui.KenyaUiUtils#formatDateTime(java.util.Date)
	 * @verifies format null date as empty string
	 */
	@Test
	public void formatDateTime_shouldFormatDateAndTime() throws Exception {
		Assert.assertThat(kenyaUi.formatDateTime(TestUtils.date(2013, 5, 4, 3, 2, 1)), is("04-May-2013 03:02"));
	}

	/**
	 * @see org.openmrs.module.kenyaui.KenyaUiUtils#formatDateTime(java.util.Date)
	 * @verifies format null date as empty string
	 */
	@Test
	public void formatDateTime_shouldFormatNullDateAsEmptyString() throws Exception {
		Assert.assertThat(kenyaUi.formatDateTime(null), is(""));
	}

	/**
	 * @see org.openmrs.module.kenyaui.KenyaUiUtils#formatDate(java.util.Date)
	 * @verifies format date as a string without time information
	 */
	@Test
	public void formatDate_shouldFormatDateWithoutTime() throws Exception {
		GregorianCalendar cal = new GregorianCalendar();
		cal.set(Calendar.YEAR, 1981);
		cal.set(Calendar.MONTH, Calendar.MAY);
		cal.set(Calendar.DAY_OF_MONTH, 28);
		cal.set(Calendar.HOUR, 7);
		cal.set(Calendar.MINUTE, 30);
		cal.set(Calendar.SECOND, 12);

		Assert.assertThat(kenyaUi.formatDate(cal.getTime()), is("28-May-1981"));
	}

	/**
	 * @see org.openmrs.module.kenyaui.KenyaUiUtils#formatDate(java.util.Date)
	 * @verifies format null date as empty string
	 */
	@Test
	public void formatDate_shouldFormatNullDateAsEmptyString() throws Exception {
		Assert.assertThat(kenyaUi.formatDate(null), is(""));
	}

	/**
	 * @see org.openmrs.module.kenyaui.KenyaUiUtils#formatDateTime(java.util.Date)
	 * @verifies format date as a string without date information
	 */
	@Test
	public void formatTime_shouldFormatTimeWithoutDate() throws Exception {
		Assert.assertThat(kenyaUi.formatTime(TestUtils.date(2013, 5, 4, 3, 2, 1)), is("03:02"));
	}

	/**
	 * @see org.openmrs.module.kenyaui.KenyaUiUtils#formatTime(java.util.Date)
	 * @verifies format null date as empty string
	 */
	@Test
	public void formatTime_shouldFormatNullDateAsEmptyString() throws Exception {
		Assert.assertThat(kenyaUi.formatTime(null), is(""));
	}

	/**
	 * @see org.openmrs.module.kenyaui.KenyaUiUtils#formatInterval(java.util.Date)
	 * @verifies return non-empty string
	 */
	@Test
	public void formatInterval_shouldReturnNonEmptyString() throws Exception {
		Assert.assertThat(StringUtils.isNotEmpty(kenyaUi.formatInterval(new Date())), is(true));
	}

	/**
	 * @see KenyaUiUtils#formatPersonName(org.openmrs.Person)
	 */
	@Test
	public void formatPersonName_shouldFormatPersonName() {
		Person p = new Person();

		PersonName pn = new PersonName();
		pn.setFamilyName("fff");
		pn.setGivenName("ggg");
		pn.setMiddleName("mmm");
		p.setNames(Collections.singleton(pn));

		Assert.assertThat(kenyaUi.formatPersonName(p), is("fff, ggg mmm"));

		// Check no middle name
		pn = new PersonName();
		pn.setFamilyName("fff");
		pn.setGivenName("ggg");
		p.setNames(Collections.singleton(pn));

		Assert.assertThat(kenyaUi.formatPersonName(p), is("fff, ggg"));

		// Check with voided person who has no-name
		p.setNames(Collections.<PersonName>emptySet());

		Assert.assertThat(kenyaUi.formatPersonName(p), is(""));
	}

	/**
	 * @see KenyaUiUtils#formatPersonBirthdate(org.openmrs.Person)
	 */
	@Test
	public void formatPersonBirthdate() {
		Person p = new Person();
		p.setBirthdate(TestUtils.date(2000, 1, 1));
		Assert.assertThat(kenyaUi.formatPersonBirthdate(p), is("01-Jan-2000"));

		p = new Person();
		p.setBirthdate(TestUtils.date(1980, 6, 30));
		p.setBirthdateEstimated(true);
		Assert.assertThat(kenyaUi.formatPersonBirthdate(p), is("approx 30-Jun-1980"));
	}

	/**
	 * @see KenyaUiUtils#fetchConcepts(java.util.Collection)
	 * @verifies fetch from concepts, integers or strings
	 */
	@Test
	public void fetchConcepts_shouldFetchFromConceptsIntegersOrStrings() {
		Concept weightKg = Context.getConceptService().getConcept(5089);
		List<Object> conceptsOrIds = new ArrayList<Object>();
		conceptsOrIds.add(weightKg);
		conceptsOrIds.add(5089);
		conceptsOrIds.add("c607c80f-1ea9-4da3-bb88-6276ce8868dd");
		List<Concept> concepts = kenyaUi.fetchConcepts(conceptsOrIds);
		org.junit.Assert.assertEquals(weightKg, concepts.get(0));
		org.junit.Assert.assertEquals(weightKg, concepts.get(1));
		org.junit.Assert.assertEquals(weightKg, concepts.get(2));
	}

	/**
	 * @see KenyaUiUtils#fetchConcepts(java.util.Collection)
	 * @verifies throw exception for non concepts, integers or strings
	 */
	@Test
	public void fetchConcepts_shouldThrowExceptionForNonConceptsIntegersOrString() {
		try {
			kenyaUi.fetchConcepts(Collections.singletonList(new Date()));
			org.junit.Assert.fail();
		}
		catch (IllegalArgumentException ex) {
		}
	}
}