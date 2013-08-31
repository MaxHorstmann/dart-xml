import 'package:xml/xml.dart';

/*
 * This XML library is mainly focused on dealing with xml fragments.  It does
 * not contemplate fully formed XML documents with top-level declarations.
 *
 * It does support xml namespaces, and namespace context enforcement.
 *
 * The primary use-case for this library is for dealing with xml-based data
 * exchange, where JSON is not supported or appropriate.
 */

// de-serializing xml into object structure
// we will use this for most of the examples
XmlElement books = XML.parse(example);

main(){
// Uncomment the example(s) you want to work with:

  simpleHello();
//  getNodeNameAndChildNodes();
//  findAttributesOfElement();
//  addAttributeToElement();
//  serializing();
}

void simpleHello(){
  print('Simple XML API demonstration:');

  // deserialize
  XmlElement hello = XML.parse('<hello>world</hello>');
  // serialize - in this case to console
  print('$hello');
  print('');
}

void getNodeNameAndChildNodes(){
  print('Accessing the node name and children of an element:');

  //children is just a collection of XmlElement types
  print('Top node called "${books.name}" has ${books.children.length}'
    ' children.');
}

void findAttributesOfElement(){
  print('Accessing the attributes of an element');

  // finding attributes of an element
  XmlElement firstBook = books.children.first;

  print('Book "${firstBook.name}" has ${firstBook.attributes.length}'
    ' attributes:');

  print('${firstBook.attributes}');
}

void addAttributeToElement(){
  print('Adding an attribute to an Element programmatically.');
  XmlElement firstBook = books.children.first;

  print('\nBefore:');
  print('${firstBook}');

  // modifying on the fly
  // in this case we will add a new attribute to the first book
  firstBook.attributes['onsale'] = 'true';

  print('\nAfter (now with the "onsale" attribute added):');
  print('${firstBook}');
}

void serializing(){
  print('Serializing an XmlElement tree');

  // since we already have the xml in object form in 'books', serializing
  // it to text is simply a matter of calling toString() on whichever node
  // you want to serialize:

  print('The entire tree:');
  String serialized = '$books'; // or books.toString()
  print(serialized);

  // child node
  print('\nJust a child node:');
  String singleNode = '${books.children.first}';
  print(singleNode);
}


String example =
''' 
<books>
  <book id='1' instock='true'>
    <title>ABCs</title>
    <subject>Self Help</subject>
    <author>Sydney O'Shannahan</author>
  </book>
  <book id='2' instock='false'>
    <title>Build A House</title>
    <subject>Self Help</subject>
    <author>Marko Stajic</author>
  </book>
  <book id='3' instock='true'>
    <title>A Bridge Too Expensive</title>
    <subject>Fiction</subject>
    <author>Stefan Handsomly</author>
  </book>
  <book id='4' instock='false'>
    <title>My Cousin Ed</title>
    <subject>Fiction</subject>
    <author>Jasna Bradshaw</author>
  </book>
  <book id='5' instock='true'>
    <title>Boring Places</title>
    <subject>Travel & Leisure</subject>
    <author>John Henryson</author>
  </book>
  <book id='6' instock='false'>
    <title>Ice 10</title>
    <subject>Fiction</subject>
    <author>Stefan Handsomly</author>
  </book>
</books>
''';