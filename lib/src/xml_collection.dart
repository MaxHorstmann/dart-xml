part of xml_utils_prujohn;

/**
* Represents a queryable collection of [XmlNode] elements.
*/
class XmlCollection<E extends XmlNode> extends ListBase<E> {
  final List<E> _collection = new List<E>();

  XmlCollection._internal();

  XmlCollection._from(Iterable<E> iterable) {
    _collection.addAll(iterable);
  }

  /**
   * Returns the element at the given [index] in the list or throws
   * an [RangeError] if [index] is out of bounds.
   */
  E operator [](int index) => _collection[index];

  /**
   * Sets the entry at the given [index] in the list to [value].
   * Throws an [RangeError] if [index] is out of bounds.
   */
  void operator []=(int index, E value) {
    _collection[index] = value;
  }

  int get length => _collection.length;

  /**
   * Changes the length of the list. If [newLength] is greater than
   * the current [length], entries are initialized to [:null:]. Throws
   * an [UnsupportedError] if the list is not extendable.
   */
  void set length(int newLength) {
    _collection.length = newLength;
  }

  XmlCollection<XmlElement> allElements() =>
      new XmlCollection._from(_collection.where((n) => n is XmlElement));

  /**
  * Returns the first node in the tree that matches the given [queryOn]
  * parameter.
  *
  * ## Usage ##
  * * query('tagName') // returns first occurance matching tag name.
  * * query(XmlNodeType.CDATA) // returns first occurance of element matching
  * the given node type (CDATA node in this example).
  * * query({'attributeName':'attributeValue'}) // returns the first occurance
  * of any [XmlElement] where the given attributes/values are found.
  */
  XmlCollection<E> query(queryOn){
    XmlCollection<E> list = new XmlCollection._internal();

    if (queryOn is String){
      for (final node in this.allElements()){
        _queryNameInternal(queryOn, list, node);
        if (!list.isEmpty) break;
      }
    }else if (queryOn is XmlNodeType){
      for (final node in this){
        _queryNodeTypeInternal(queryOn, list, node);
        if (!list.isEmpty) break;
      }
    }else if (queryOn is Map){
      for (final node in this.allElements()){
        _queryAttributeInternal(queryOn, list, node);
        if (!list.isEmpty) break;
      }
    }

    return list;
  }


  void _queryAttributeInternal(Map aMap,
                               XmlCollection<E> list,
                               XmlElement n){
    bool checkAttribs(){
      var succeed = true;

      //TODO needs better implementation to
      //break out on first false
      aMap.forEach((k, v){
        if (succeed && n.attributes.containsKey(k)) {
          if (n.attributes[k] != v) succeed = false;
        }else{
          succeed = false;
        }
      });

      return succeed;
    }

    if (checkAttribs()){
      list.add(n);
      return;
    }else{
      if (n.hasChildren){
        n.children
        .allElements()
        .forEach((el){
          if (!list.isEmpty) return;
          (el as XmlElement)._queryAttributeInternal(aMap, list);
        });
      }
    }
  }

  void _queryNodeTypeInternal(XmlNodeType nodeType,
                              XmlCollection<E> list,
                              XmlNode node){
    if (node.type == nodeType){
      list.add(node);
      return;
    }else{
      if ((node as XmlElement).hasChildren){
        (node as XmlElement).children
          .forEach((el){
            if (!list.isEmpty) return;
            if (el is XmlElement){
              el._queryNodeTypeInternal(nodeType, list);
            }else{
              if (el.type == nodeType){
                list.add(el);
                return;
              }
            }
          });
      }
    }
  }

  void _queryNameInternal(String tagName, XmlCollection<E> list,
                          XmlElement element){

    if (element.name == tagName){
      list.add(element);
      return;
    }else{
      if (element.hasChildren){
        element.children
          .allElements()
          .forEach((el){
            if (!list.isEmpty) return;
            el._queryNameInternal(tagName, list);
          });
      }
    }
  }

  /**
  * Returns a list of nodes in the tree that match the given [queryOn]
  * parameter.
  *
  * ## Usage ##
  * * query('tagName') = returns first occurance matching tag name.
  * * query(XmlNodeType.CDATA) // returns first occurance of element matching
  * the given node type (CDATA node in this example).
  */
  XmlCollection<E> queryAll(queryOn){
    var list = new XmlCollection<E>._internal();

    if (queryOn is String){
      for (final node in this.allElements()){
        _queryAllNamesInternal(queryOn, list, node);
      }
    }else if (queryOn is XmlNodeType){
      for (final node in this){
        _queryAllNodeTypesInternal(queryOn, list, node);
      }
    }else if (queryOn is Map){
      for (final node in this.allElements()){
        _queryAllAttributesInternal(queryOn, list, node);
      }
    }

    return list;
  }

  void _queryAllAttributesInternal(Map aMap,
                                   XmlCollection<E> list,
                                   XmlElement element){
    bool checkAttribs(){
      var succeed = true;

      //TODO needs better implementation to
      //break out on first false
      aMap.forEach((k, v){
        if (succeed && element.attributes.containsKey(k)) {
          if (element.attributes[k] != v) succeed = false;
        }else{
          succeed = false;
        }
      });

      return succeed;
    }

    if (checkAttribs()){
      list.add(element);
    }else{
      if (element.hasChildren){
        element.children
        .allElements()
        .forEach((el){
          el._queryAttributeInternal(aMap, list);
        });
      }
    }
  }

  void _queryAllNodeTypesInternal(XmlNodeType nodeType,
                                  XmlCollection<E> list,
                                  XmlNode node){
    if (node.type == nodeType){
      list.add(node);
    }else{
      if ((node as XmlElement).hasChildren){
        (node as XmlElement).children
          .forEach((el){
            if (el is XmlElement){
              el._queryAllNodeTypesInternal(nodeType, list);
            }else{
              if (el.type == nodeType){
                list.add(el);
              }
            }
          });
      }
    }
  }

  void _queryAllNamesInternal(String tagName,
                         XmlCollection<E> list,
                         XmlElement element){
    if (element.name == tagName){
      list.add(element);
    }

    if (element.hasChildren){
      element.children
      .where((el) => el is XmlElement)
      .forEach((el){
        el._queryAllNamesInternal(tagName, list);
      });
    }
  }
}
