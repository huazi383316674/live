[#ftl /]
<div id="${tag.id}"></div>

<script type="text/javascript">
	bar = bg.ui.toolbar("${tag.id}"[#if tag.title??],'${tag.title?replace("'","\"")} [#if tag.spanId??]&nbsp;&nbsp;&nbsp;&nbsp;<span id="${tag.spanId}" style="border:1px; background:#9ea9c5"></span>[/#if]'[/#if]);
	${tag.body}
	bar.addHr();
</script>
