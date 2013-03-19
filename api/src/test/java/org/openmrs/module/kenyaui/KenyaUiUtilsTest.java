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

import junit.framework.Assert;
import org.apache.commons.lang.StringUtils;
import org.junit.Test;
import org.openmrs.web.WebConstants;
import org.springframework.mock.web.MockHttpSession;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class KenyaUiUtilsTest {

	private KenyaUiUtils kenyaUi = new KenyaUiUtils();

	@Test
	public void notifySuccess_shouldSetMessageSessionAttribute() {
		MockHttpSession session = new MockHttpSession();
		kenyaUi.notifySuccess(session, "test");

		Assert.assertEquals("test", session.getAttribute(WebConstants.OPENMRS_MSG_ATTR));
	}

	@Test
	public void notifySuccess_shouldSetErrorSessionAttribute() {
		MockHttpSession session = new MockHttpSession();
		kenyaUi.notifyError(session, "test");

		Assert.assertEquals("test", session.getAttribute(WebConstants.OPENMRS_ERROR_ATTR));
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

		Assert.assertEquals("28-May-1981", kenyaUi.formatDate(cal.getTime()));
	}

	/**
	 * @see org.openmrs.module.kenyaui.KenyaUiUtils#formatDate(java.util.Date)
	 * @verifies format null date as empty string
	 */
	@Test
	public void formatDate_shouldFormatNullDateAsEmptyString() throws Exception {
		Assert.assertEquals("", kenyaUi.formatDate(null));
	}

	/**
	 * @see org.openmrs.module.kenyaui.KenyaUiUtils#formatInterval(java.util.Date)
	 * @verifies return non-empty string
	 */
	@Test
	public void formatInterval_shouldReturnNonEmptyString() throws Exception {
		Assert.assertTrue(StringUtils.isNotEmpty(kenyaUi.formatInterval(new Date())));
	}
}