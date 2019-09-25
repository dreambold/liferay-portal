<%--
/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %><%@
taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>

<%@ page import="com.liferay.petra.string.StringPool" %><%@
page import="com.liferay.portal.kernel.language.UnicodeLanguageUtil" %><%@
page import="com.liferay.portal.kernel.util.HtmlUtil" %><%@
page import="com.liferay.portal.kernel.util.WebKeys" %><%@
page import="com.liferay.portal.search.web.internal.modified.facet.display.context.ModifiedFacetCalendarDisplayContext" %><%@
page import="com.liferay.portal.search.web.internal.modified.facet.display.context.ModifiedFacetDisplayContext" %><%@
page import="com.liferay.portal.search.web.internal.modified.facet.display.context.ModifiedFacetTermDisplayContext" %>

<portlet:defineObjects />

<style>
	.facet-checkbox-label {
		display: block;
	}

	.facet-term-selected {
		font-weight: 600;
	}

	.facet-term-unselected {
		font-weight: 400;
	}
</style>

<%
ModifiedFacetDisplayContext modifiedFacetDisplayContext = (ModifiedFacetDisplayContext)java.util.Objects.requireNonNull(request.getAttribute(WebKeys.PORTLET_DISPLAY_CONTEXT));

ModifiedFacetTermDisplayContext customRangeModifiedFacetTermDisplayContext = modifiedFacetDisplayContext.getCustomRangeModifiedFacetTermDisplayContext();

ModifiedFacetCalendarDisplayContext modifiedFacetCalendarDisplayContext = modifiedFacetDisplayContext.getModifiedFacetCalendarDisplayContext();
%>

<c:if test="<%= !modifiedFacetDisplayContext.isRenderNothing() %>">
	<liferay-ui:panel-container
		extended="<%= true %>"
		id='<%= renderResponse.getNamespace() + "facetModifiedPanelContainer" %>'
		markupView="lexicon"
		persistState="<%= true %>"
	>
		<liferay-ui:panel
			collapsible="<%= true %>"
			cssClass="search-facet"
			id='<%= renderResponse.getNamespace() + "facetModifiedPanel" %>'
			markupView="lexicon"
			persistState="<%= true %>"
			title="last-modified"
		>
			<aui:form method="get" name="modifiedFacetForm">
				<aui:input autocomplete="off" name="inputFacetName" type="hidden" value="modified" />
				<aui:input cssClass="facet-parameter-name" name="facet-parameter-name" type="hidden" value="<%= modifiedFacetDisplayContext.getParameterName() %>" />

				<aui:field-wrapper cssClass='<%= renderResponse.getNamespace() + "calendar calendar_" %>' label="" name="<%= HtmlUtil.escapeAttribute(modifiedFacetDisplayContext.getParameterName()) %>">
					<ul class="list-unstyled modified">

						<%
						for (ModifiedFacetTermDisplayContext modifiedFacetTermDisplayContext : modifiedFacetDisplayContext.getModifiedFacetTermDisplayContexts()) {
						%>

							<li class="facet-value" name="<%= renderResponse.getNamespace() + "range_" + modifiedFacetTermDisplayContext.getLabel() %>">
								<a href="<%= modifiedFacetTermDisplayContext.getRangeURL() %>">
									<span class="term-name <%= modifiedFacetTermDisplayContext.isSelected() ? "facet-term-selected" : "facet-term-unselected" %>">
										<liferay-ui:message key="<%= modifiedFacetTermDisplayContext.getLabel() %>" />
									</span>

									<small class="term-count">
										(<%= modifiedFacetTermDisplayContext.getFrequency() %>)
									</small>
								</a>
							</li>

						<%
						}
						%>

						<li class="facet-value" name="<%= renderResponse.getNamespace() + "range_" + customRangeModifiedFacetTermDisplayContext.getLabel() %>">
							<a href="<%= customRangeModifiedFacetTermDisplayContext.getRangeURL() %>" id="<portlet:namespace /><%= customRangeModifiedFacetTermDisplayContext.getLabel() + "-toggleLink" %>">
								<span class="term-name <%= customRangeModifiedFacetTermDisplayContext.isSelected() ? "facet-term-selected" : "facet-term-unselected" %>"><liferay-ui:message key="<%= customRangeModifiedFacetTermDisplayContext.getLabel() %>" />&hellip;</span>

								<c:if test="<%= customRangeModifiedFacetTermDisplayContext.isSelected() %>">
									<small class="term-count">
										(<%= customRangeModifiedFacetTermDisplayContext.getFrequency() %>)
									</small>
								</c:if>
							</a>
						</li>

						<div class="<%= !modifiedFacetCalendarDisplayContext.isSelected() ? "hide" : StringPool.BLANK %> modified-custom-range" id="<portlet:namespace />customRange">
							<div class="col-md-6" id="<portlet:namespace />customRangeFrom">
								<aui:field-wrapper label="from">
									<liferay-ui:input-date
										cssClass="modified-facet-custom-range-input-date-from"
										dayParam="fromDay"
										dayValue="<%= modifiedFacetCalendarDisplayContext.getFromDayValue() %>"
										disabled="<%= false %>"
										firstDayOfWeek="<%= modifiedFacetCalendarDisplayContext.getFromFirstDayOfWeek() %>"
										monthParam="fromMonth"
										monthValue="<%= modifiedFacetCalendarDisplayContext.getFromMonthValue() %>"
										name="fromInput"
										yearParam="fromYear"
										yearValue="<%= modifiedFacetCalendarDisplayContext.getFromYearValue() %>"
									/>
								</aui:field-wrapper>
							</div>

							<div class="col-md-6" id="<portlet:namespace />customRangeTo">
								<aui:field-wrapper label="to">
									<liferay-ui:input-date
										cssClass="modified-facet-custom-range-input-date-to"
										dayParam="toDay"
										dayValue="<%= modifiedFacetCalendarDisplayContext.getToDayValue() %>"
										disabled="<%= false %>"
										firstDayOfWeek="<%= modifiedFacetCalendarDisplayContext.getToFirstDayOfWeek() %>"
										monthParam="toMonth"
										monthValue="<%= modifiedFacetCalendarDisplayContext.getToMonthValue() %>"
										name="toInput"
										yearParam="toYear"
										yearValue="<%= modifiedFacetCalendarDisplayContext.getToYearValue() %>"
									/>
								</aui:field-wrapper>
							</div>

							<aui:button cssClass="modified-facet-custom-range-filter-button" disabled="<%= modifiedFacetCalendarDisplayContext.isRangeBackwards() %>" name="searchCustomRangeButton" value="search" />
						</div>
					</ul>
				</aui:field-wrapper>

				<c:if test="<%= !modifiedFacetDisplayContext.isNothingSelected() %>">
					<aui:a cssClass="modified-facet-a-clear text-default" href="javascript:;" onClick="Liferay.Search.ModifiedFacetFilterUtil.clearSelections(event);">
						<small><liferay-ui:message key="clear" /></small>
					</aui:a>
				</c:if>
			</aui:form>
		</liferay-ui:panel>
	</liferay-ui:panel-container>

	<aui:script use="liferay-search-modified-facet">
		new Liferay.Search.ModifiedFacetFilter(A.one('#<portlet:namespace/>modifiedFacetForm'), Liferay.component('<portlet:namespace />fromInputDatePicker'), Liferay.component('<portlet:namespace />toInputDatePicker'));
	</aui:script>
</c:if>

<aui:script use="aui-form-validator">
	var Util = Liferay.Util;

	var customRangeFrom = Liferay.component('<%= renderResponse.getNamespace() %>fromInputDatePicker');
	var customRangeTo = Liferay.component('<%= renderResponse.getNamespace() %>toInputDatePicker');
	var searchButton = A.one('#<portlet:namespace />searchCustomRangeButton');

	var preventKeyboardDateChange = function(event) {
		if (!event.isKey('TAB')) {
			event.preventDefault();
		}
	};

	A.one('#<portlet:namespace />fromInput').on('keydown', preventKeyboardDateChange);
	A.one('#<portlet:namespace />toInput').on('keydown', preventKeyboardDateChange);

	var DEFAULTS_FORM_VALIDATOR = A.config.FormValidator;

	A.mix(
		DEFAULTS_FORM_VALIDATOR.STRINGS,
		{
			<portlet:namespace />dateRange: '<%= UnicodeLanguageUtil.get(request, "search-custom-range-invalid-date-range") %>'
		},
		true
	);

	A.mix(
		DEFAULTS_FORM_VALIDATOR.RULES,
		{
			<portlet:namespace />dateRange: function(val, fieldNode, ruleValue) {
				return A.Date.isGreaterOrEqual(customRangeTo.getDate(), customRangeFrom.getDate());
			}
		},
		true
	);

	var customRangeValidator = new A.FormValidator(
		{
			boundingBox: document.<portlet:namespace />modifiedFacetForm,
			fieldContainer: 'div',
			on: {
				errorField: function(event) {
					Util.toggleDisabled(searchButton, true);
				},
				validField: function(event) {
					Util.toggleDisabled(searchButton, false);
				}
			},
			rules: {
				'<portlet:namespace />fromInput': {
					<portlet:namespace />dateRange: true
				},
				'<portlet:namespace />toInput': {
					<portlet:namespace />dateRange: true
				}
			}
		}
	);

	var onRangeSelectionChange = function(event) {
		customRangeValidator.validate();
	};

	customRangeFrom.on('selectionChange', onRangeSelectionChange);
	customRangeTo.on('selectionChange', onRangeSelectionChange);
</aui:script>