## Dart Xml ##
Dart Xml is a lightweight library for parsing and emitting xml.

## What "Lightweight" Means ##
Many programmatic scenarios concerning XML deal with serialization and
deserialization of data, usually for transmission between services).
The querying of said data in object form is also important.  Typically
these data are XML fragments and not fully formed XML documents.  Even so,
the library is able to deal with fully formed XML documents.

Dart Developers who require more robust XML handling are encouraged to fork the
project and expand as needed.  Pull requests will certainly be welcomed.

## Getting Started ##
See the "getting_started.md" file in the **doc/** directory of the project.

### Parsing ###
    // Returns a strongly-typed XmlNode tree
    XmlElement myXmlTree = XML.parse(myXmlString);

### Serialization ###
	// Returns a stringified xml document from a given XmlNode tree
	String myXmlString = XML.stringify(myXmlNode);

	// or...
	String myXmlString = myXmlNode.toString();

## Supports ##
* Standard well-formed XML
* Comment nodes
* CDATA nodes
* Text nodes
* Namespace declarations and usage
* Processing Instruction (PI) nodes
* Querying of XML nodes by tagName, attribute(s), or XmlNodeType (combinators
soon hopefully)
* Top-Level Declarations

## Limitations ##
* Doesn't enforce DTD
* Doesn't enforce any local schema declarations

## License ##
Apache 2.0