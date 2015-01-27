# ※※※ L10NE ※※※
LION ENGINE - flash content externalization and localization system

**note** - codebase is in extreme prerelease state, probably doesn't work at all. don't trust anyone, even me.

lionize(string with id)

##Usage

```
<config defaultDict="de.xml">
	<textField1>※A1</textField1>
</config>
```

```
<dictionary id="de" englishName="German" localName="Deutsch">
	<entry id="A1" font="" size="" kerning="" leading="" color="">Le Test</entry>
</dictionary>
```

```
LION.init('config.xml');

var textField:TextField = new TextField();
LION.lionize(textField,LION.configXML.textField1);
addChild(textField);
```