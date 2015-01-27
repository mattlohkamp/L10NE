# ※ L10NE ※

*LION Engine - the flash content externalization and localization system.*

**note** - codebase is in extreme prerelease state, probably doesn't work at all! don't use it!

##Story Time

'L10N' is a [numeronym](http://en.wikipedia.org/wiki/Numeronym) used as industry shorthand for "[localization](http://en.wikipedia.org/wiki/Language_localisation)" - essentially the practice of defining equivalent content blocks for different geographic locations, generally broken up by language, but sometimes also distinct cultures. For instance, even in the same basic language, different regions might prefer different forms of a particular word - or might identify more with a different image as evoking a particular emotion. In a non-language example, in colourblind-friendly mode, green and red text might be styled slightly differently, and instructions might be worded accordingly.

Text marked for localization ('lionization') by LionEngine is delineated from other content by the addition of the [japenese *kome* glyph](http://www.fileformat.info/info/unicode/char/203b/index.htm): **※**, a choice which is part whimsy, part practical; this symbol is fairly obscure and is unlikely to be used in modern typeset content, and looks kinda cool. (changing which glyph to look for or pattern to match to recognize lionizable content is an included piece of LIONE functionality - note that **use of '※' symbol requires UTF-8 encoding**.)

Finally, 'L10N' looks a lot like 'LION,' and 'Engine' starts with an 'E,' therefore the name.

##Dev Direction / timeline

1.	~~basic documentation outline~~
2.	lionize basic init
3.	lionize String
4.	lionize XML
5.	lionize feature buff and init / dictionary switching
6.	completed example / demo
7.	completed documentation
8.	bug test / fix / stuff?
9.	release!

##Documentation

In general, content marked for localisation will include the *kome* (※) glyph, marking the proceeding text as the 'LionID,' and that ID will be matched against a node in the current dictionary. The main 'L10NE.lionize' method behaves a bit differently depending on what content it is fed to localise, but here's an outline:

```as3
L10NE.lionize(
	target:*,	//	string with LionID glyph, XML with LionID attribute
	dictionary:String = null	//	optionally force to pull from a specific dictionary, choosing from the identifiers specified in the current LIONE.configXML
);
```

### String
```as3
lionize(string);
```

Takes a kome string and returns the localized version.

### XML Node
```as3
lionize(xmlNode);
```

Takes a XML object that includes a LionID attribute (e.g. `LionID="※abc123"`) and returns the localized version.

## Example Usage

For a more hands-on example, see the contents of '\demo'

```xml
<config defaultDict="de.xml">
	<textField1>※A1</textField1>
</config>
```

```xml
<dictionary id="de" englishName="German" localName="Deutsch">
	<entry id="A1" font="" size="" kerning="" leading="" color="">Le Test</entry>
</dictionary>
```

```as3
LION.init('config.xml');

var textField:TextField = new TextField();
LION.lionize(textField,LION.configXML.textField1);
addChild(textField);
```