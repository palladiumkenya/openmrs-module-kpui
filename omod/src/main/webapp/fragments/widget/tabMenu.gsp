<%
	config.require("items")
%>
<div class="ke-tabmenu">
<% config.items.each { item -> %>
	<div class="ke-tabmenu-item" data-tabid="${ item.tabid }">${ item.label }</div>
<% } %>
</div>