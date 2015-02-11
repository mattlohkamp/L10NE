# L10NE

*LION Engine - the flash content externalization and localization system.*

**note** - codebase is in extreme prerelease state, probably doesn't work at all! don't use it!

## About the engine

'L10N' is a [numeronym](http://en.wikipedia.org/wiki/Numeronym) used as industry shorthand for "[localization](http://en.wikipedia.org/wiki/Language_localisation)" - essentially the practice of defining equivalent content blocks for different geographic locations, generally broken up by language, but sometimes also distinct cultures. For instance, even in the same basic language, different regions might prefer different forms of a particular word - or might identify more with a different image as evoking a particular emotion. In a non-language example, in colourblind-friendly mode, green and red text might be styled slightly differently, requiring instructions to be reworded accordingly.

Just in case you haven't already fiugred it out - 'L10N' looks a lot like 'LION,' and 'Engine' starts with an 'E,' therefore the name.

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

### Dictionary Formatting

```xml
    <dictionary id="lat" label="Lorem Ipsum" nativeName="Latin">
            <!--    simple string value -->
    	<string lionid="Text1">Lorem ipsum dolor sit amet</string>
    	    <!--    node value with attribute   -->
    	<node lionid="Node1" repeat="1"><![CDATA[Donec gravida sem sit amet congue lobortis]]></node>
    </dictionary>
```

### Initialization - `L10NE.init()`

```as3
L10NE.init(configOptions:Object = {  PreserveLionID:Boolean = true   });
```

 - **PreserveLionID** - set to `false` to strip the `lionid` attribute from returned lionized XML nodes 

### Adding a new dictionary - `L10NE.addDictionary()`

```as3
L10NE.addDictionary(dictReference:L10NEDictionary);
```

You're responsible for making your own `L10NEDictionary` instance to pass in, but it can be as simple as this:

```as3
L10NE.addDictionary(new L10NEDictionary(<dictionary id="eng"><string lionid="test1">Hello, World</string></dictionary>));
```

Most likely you'll be loading the XML document using an `URLLoader`, casting the return value of the `.data` accessor as XML and passing it into the `L10NEDictionary()` constructor to instanciate the new dictionary, then passing that into `L10NE.addDictionary`.

### General Usage - `lionize()`

XML nodes marked for localisation will include a `lionid` attribute, and that ID will be matched against a node in the current dictionary.

```as3
    L10NE.lionize(
    	target:*,	//	lionid String, or XML with lionid attribute
    	dictionary:String = null	//	optionally force to pull from a specific dictionary, keyed to id String in the root <dictionary> element
    );
```

### Case: String Localization

```as3
L10NE.lionize(LionID:String):XML;
```

Takes a `lionid` and returns the corresponding `XML` node from the current (or specified) `L10NEDictionary`.

### Case: XML Node Localization
```as3
L10NE.lionize(xmlNode:XML):XML;
```

Takes an `XML` object that includes a `lionid` attribute (e.g. `lionid="abc123"`) and returns the localized version, according to the following strict rules: Any attribute on the localized node will always either overwrite the value of the corresponding attribute on the non-localized node - or add that attribute to the non-localized node if it isn't already present. In addition, the node contents (whether text or nested child nodes) will be copied wholesale from the localized node to the non-localized - except in the case of the localized node being empty, the only case in which the originla node's contents is preserved.

Here's an example of what that process looks like:

#### 1.) Original (non-localized) XML content

```xml
    <xml>
        <content1 lionid="String1"></content1>
        <content2 lionid="Node1" style="blue">Generic 1</content2>
        <content3 lionid="Node2" type="horizontal">
            <img src="image1.jpg" />
            <img src="image2.jpg" />
            <img src="image3.jpg" />
        </content3>
    </xml>
```

#### 2.) Localized XML content, from dictionary XML

```xml
    <dictionary id="dict">
        <string lionid="String1">Local String 1</string>
        <node lionid="Node1" style="red" />
        <node lionid="Node2" type="vertical" max="2">
            <img src="image1.jpg" />
            <img src="image2.jpg" />
            <img src="image4.jpg" />
            <img src="image5.jpg" />
        </node>
    </dictionary>
```

#### 3.) Final XML content, with localized merged in on top of original

```xml
    <xml>
        <!--    string value substituted    -->
        <content1 lionid="String1">Local String 1</content1>
        <!--    only attribute value changed, node value preserved  -->
        <content2 lionid="Node1" style="red">Generic 1</content2>
        <!--    attribute changed, new attribute added, child nodes replaced -->
        <content3 lionid="Node2" type="vertical" max="2">
            <img src="image1.jpg" />
            <img src="image2.jpg" />
            <img src="image4.jpg" />
            <img src="image5.jpg" />
        </content3>
    </xml>
```

*Note that the node names themselves (e.g. 'content3' versus 'node') are preserved from the original*

---

## Example Usage

For a more hands-on example, see the contents of '\demo'

TODO: this