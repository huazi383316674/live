[#ftl]
[@b.head/]

<table width="100%">
	<tr>
		<td >
			[@b.div id="contentDiv" /]
		</td>
	</tr>
</table>

<script>
	jQuery(function () {
		bg.Go("shoppingOrder!toAdd.action", "contentDiv");
	})
</script>
[@b.foot/]