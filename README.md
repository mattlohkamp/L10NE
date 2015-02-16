# L10NE

*LION Engine - the flash content externalization and localization system.*

## About the engine

'L10N' is a [numeronym](http://en.wikipedia.org/wiki/Numeronym) used as industry shorthand for "[localization](http://en.wikipedia.org/wiki/Language_localisation)" - essentially the practice of defining equivalent content blocks for different geographic locations, generally broken up by language, but sometimes also distinct cultures. For instance, even in the same basic language, different regions might prefer different forms of a particular word - or might identify more with a different image as evoking a particular emotion. In a non-language example, in colourblind-friendly mode, green and red text might be styled slightly differently, requiring instructions to be reworded accordingly.

Just in case you haven't already fiugred it out - 'L10N' looks a lot like 'LION,' and 'Engine' starts with an 'E,' therefore the name.

---

##Documentation

### Adding a new dictionary - `L10NE.addDictionary()`

```as3
L10NE.addDictionary(dictionary:L10NEDictionary);
```

You're responsible for making your own `L10NEDictionary` instance to pass in, but it can be as simple as this:

```as3
L10NE.addDictionary(new L10NEDictionary(<dictionary id="eng"><string lionid="test1">Hello, World</string></dictionary>));
```

Most likely you'll be loading the XML document using an `URLLoader`, casting the return value of `.data`  as `XML` and passing it into the `L10NEDictionary()` constructor to instanciate the new dictionary, then passing that into `L10NE.addDictionary`. For more concrete examples of this process, see the demo implementation files.

#### Dictionary Added Event

```as3
L10NE.addEventListener(Event.ADDED, function(e:Event):void  {});
```

*todo: add something to see what that dict was*

### Dictionary Formatting

```xml
    <dictionary id="lat" label="Lorem Ipsum" nativeName="Latin">
            <!--    simple string value -->
    	<string lionid="Text1">Lorem ipsum dolor sit amet</string>
    	    <!--    node value with attribute   -->
    	<node lionid="Node1" repeat="1"><![CDATA[Donec gravida sem sit amet congue lobortis]]></node>
    </dictionary>
```

### General Usage - `L10NE.lionize()`

XML nodes marked for localisation will include a `lionid` attribute, and that ID will be matched against a node in the current dictionary.

```as3
    L10NE.lionize(
    	target:*,	//	lionid String, or XML with lionid attribute
    	dictID:String = null	//	optionally force to pull from a specific dictionary, keyed to id String in the root <dictionary> element
    );
```

#### Case: String Localization

```as3
L10NE.lionize(LionID:String,dictID:String = null):String;
```

Takes a `lionid` and returns the corresponding `String` value from the current (or specified) `L10NEDictionary`.

#### Case: XML Node Localization

```as3
L10NE.lionize(xmlNode:XML,dictID:String = null):XML;
```

Takes an `XML` object that includes a `lionid` attribute (e.g. `lionid="abc123"`) and returns the localized version (from either the current or specified `L10NEDictionary`)

---

### Other useful functions

```as3
L10NE.getDictionaries():Array
```

returns an array of `L10NEDictionary`s, indexed by the id attribute in the root node of each dictionary's source XML.

```as3
L10NE.getDictByID(id:String):L10NEDictionary
```

returns the `L10NEDictionary` with the matching `id`.

```as3
L10NE.getCurrentDict():L10NEDictionary
```

returns the `L10NEDictionary` that `L10NE.lionize()` is currently defaults to.

```as3
L10NE.currentDictID:String  //  getter/setter
```

get the `id` of the current `L10NEDictionary`, or pick a new `L10NEDictionary` by its `id`.

#### Dictionary Changed Event

```as3
L10NE.addEventListener(Event.CHANGE, function(e:Event):void  {});
```

---

## Example Usage

For a more hands-on example, see the contents of '\demo'

```as3

    var textField:TextField = new TextField();
    addChild(textField);

    L10NE.addEventListener(Event.CHANGE, function(e:Event):void	{
        textField.text = l10ne.lionize('string1');  //  value will change when dictionary changes
    });
    
    L10NE.addDictionary(new L10NEDictionary(<dictionary id="dict1"><string lionid="string1">Foo</string></dictionary>));   //  textField value will change now, because first dictionary added sets the default dictionary value, triggering Event.CHANGE
    L10NE.addDictionary(new L10NEDictionary(<dictionary id="dict2"><string lionid="string1">Bar</string></dictionary>));
    
    L10NE.currentDictID = 'dict2';  //  textField value will change aga the second dictionary is selected.
```