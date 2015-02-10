# ※ L10NE ※

*LION Engine - the flash content externalization and localization system.*

**note** - codebase is in extreme prerelease state, probably doesn't work at all! don't use it!

## About the engine

'L10N' is a [numeronym](http://en.wikipedia.org/wiki/Numeronym) used as industry shorthand for "[localization](http://en.wikipedia.org/wiki/Language_localisation)" - essentially the practice of defining equivalent content blocks for different geographic locations, generally broken up by language, but sometimes also distinct cultures. For instance, even in the same basic language, different regions might prefer different forms of a particular word - or might identify more with a different image as evoking a particular emotion. In a non-language example, in colourblind-friendly mode, green and red text might be styled slightly differently, requiring instructions to be reworded accordingly.

Text marked for localization ('lionization') by LionEngine is delineated from other content by the addition of the [japenese *kome* glyph](http://www.fileformat.info/info/unicode/char/203b/index.htm): **※**, a choice which is part whimsy, part practical; this symbol is fairly obscure and is unlikely to be used in modern typeset content, and looks kinda cool. Also, if you notice this symbol appearing as part of content once you export your project, changes are you forgot to lionize a value somewhere. (changing which glyph to look for or pattern to match to recognize lionizable content is an included piece of LIONE functionality - note that **use of '※' symbol requires UTF-8 encoding**.)

Finally, 'L10N' looks a lot like 'LION,' and 'Engine' starts with an 'E,' therefore the name.

##Dev Direction / timeline

1.	~~basic documentation outline~~
2.	~~lionize basic init~~
3.	~~lionize String~~
4.	~~lionize XML~~
5.	lionize feature buff and init / dictionary switching
6.  add xml loader queue?
7.  allow passing in complete xml, loaded from outside?
8.  completed example / demo
9.  completed documentation
10.  bug test / fix / stuff?
11.  release!

---

##Documentation

### Initialization

```as3
    L10NE.init(configOptions:Object = {
        PreserveLionID:Boolean = true,
        LionGlyph:String = '※'
    });
```

 - **PreserveLionID** - set to `false` to strip the `lionid` attribute from localized XML nodes 
 - **LionGlyph** - set to a `String` value to use another symbol / pattern in place of the default *kome*.

## General Usage

In general, content marked for localisation will include the *kome* (※) glyph, marking the proceeding text as the 'LionID,' and that ID will be matched against a node in the current dictionary. The main 'L10NE.lionize' method behaves a bit differently depending on what content it is fed to localise, but here's an outline:

```as3
L10NE.lionize(
	target:*,	//	string with LionID glyph, XML with LionID attribute
	dictionary:String = null	//	optionally force to pull from a specific dictionary, choosing from the identifiers specified in the current LIONE.configXML
);
```

### String Localization
```as3
lionize(string);
```

Takes a kome string and returns the localized version.

### XML Node Localization
```as3
lionize(xmlNode);
```

Takes a XML object that includes a LionID attribute (e.g. `LionID="※abc123"`) and returns the localized version, according to the following strict rules: Any attribute on the localized node will always either overwrite the value of the corresponding attribute on the non-localized node - or add that attribute to the non-localized node if it isn't already present. In addition, the node contents (whether text or nested child nodes) will be copied wholesale from the localized node to the non-localized - except in the case of the localized node being empty, the only case in which the originla node's contents is preserved.

Here's an example of what that process looks like:

#### Original (non-localized) XML content

```xml
    <xml>
        <node>※String1</node>
        <node lionid="※Node1" style="blue">Generic 1</node>
        <node lionid="※Node2" type="horizontal">
            <item src="image1.jpg" />
            <item src="image2.jpg" />
            <item src="image3.jpg" />
        </node>
    </xml>
```

#### Localized XML content, from dictionary XML

```xml
    <dictionary>
        <entry id="String1">Local String 1</entry>
        <entry id="Node1" style="red" />
        <entry id="Node2" type="vertical" max="2">
            <item src="image1.jpg" />
            <item src="image1.jpg" />
            <item src="image4.jpg" />
            <item src="image5.jpg" />
        </entry>
    </dictionary>
```

#### Final XML content, with localized merged in on top of original

```xml
    <xml>
        <!--    string value substituted    -->
        <node>Local String 1</node>
        <!--    only attribute value changed, node value preserved  -->
        <node lionid="※Node1" style="red">Generic 1</node>
        <!--    attribute changed, new attribute added, node value replaced -->
        <node lionid="※Node2" type="vertical" max="2">
            <item src="image1.jpg" />
            <item src="image1.jpg" />
            <item src="image4.jpg" />
            <item src="image5.jpg" />
        </node>
    </xml>
```

---

## Example Usage

For a more hands-on example, see the contents of '\demo'

```xml
    <xml>
    	<text>※String1</text>
    	<node lionid="※Node1" firstSlide="1">
    	    <img src="image1.jpg" />
    	    <img src="image2.jpg" />
    	</node>
    </xml>
```

```xml
    <dictionary id="de" englishName="German" localName="Deutsch">
    	<entry id="String1">erste Wert</entry>
    	<node id="Node1" firstSlide="1">
    	    <img src="image1de.jpg" />
    	    <img src="image2de.jpg" />
    	</node>
    </dictionary>
```

```as3
LION.init({PreserveLionID:false});
LION.addDictionary();

var textField:TextField = new TextField();
LION.lionize(textField,LION.configXML.textField1);
addChild(textField);
```