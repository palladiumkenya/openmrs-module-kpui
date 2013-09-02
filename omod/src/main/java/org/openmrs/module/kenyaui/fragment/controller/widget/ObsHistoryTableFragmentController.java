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
package org.openmrs.module.kenyaui.fragment.controller.widget;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.openmrs.Concept;
import org.openmrs.ConceptNumeric;
import org.openmrs.Obs;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.kenyaui.KenyaUiUtils;
import org.openmrs.ui.framework.annotation.FragmentParam;
import org.openmrs.ui.framework.annotation.SpringBean;
import org.openmrs.ui.framework.fragment.FragmentModel;
import org.openmrs.util.OpenmrsUtil;

/**
 * Controller for the obsTableByDate fragment
 */
public class ObsHistoryTableFragmentController {

	public void controller(@FragmentParam("patient") Patient patient, @FragmentParam("concepts") List<Concept> concepts, FragmentModel model, @SpringBean KenyaUiUtils kenyaUi) {
		if (concepts.size() < 1) {
			throw new IllegalArgumentException("Concept list must be non-empty");
		}

		model.addAttribute("concepts", concepts);

		TableData data = new TableData();
		for (Concept concept : concepts) {
			List<Obs> obss = Context.getObsService().getObservationsByPersonAndConcept(patient, concept);
			for (Obs obs : obss) {
				data.addObs(obs);
			}
		}

		model.addAttribute("data", data);
	}

	/**
	 * Underlying model for the table data
	 */
	public class TableData extends TreeMap<Date, Map<Concept, List<Obs>>> {

		public TableData() {
			super(new Comparator<Date>() {
				@Override
				public int compare(Date left, Date right) {
					return right.compareTo(left);
				}
			});
		}

		/**
		 * Adds an obs to the table data
		 * @param obs the obs
		 */
		public void addObs(Obs obs) {
			Concept concept = obs.getConcept();
			Date dateNoTime = OpenmrsUtil.firstSecondOfDay(obs.getObsDatetime());

			Map<Concept, List<Obs>> allObsDate = get(dateNoTime);
			if (allObsDate == null) {
				allObsDate = new HashMap<Concept, List<Obs>>();
				put(dateNoTime, allObsDate);
			}
			List<Obs> obsForConceptOnDate = allObsDate.get(concept);
			if (obsForConceptOnDate == null) {
				obsForConceptOnDate = new ArrayList<Obs>();
				allObsDate.put(concept, obsForConceptOnDate);
			}

			obsForConceptOnDate.add(obs);
		}
	}
}
