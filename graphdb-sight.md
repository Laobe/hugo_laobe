## GraphDB语法初见
之前一直有在关注arangodb的开发进程，现在看到arangodb出了一份[各个图数据库的对比测试](https://www.arangodb.com/2018/02/nosql-performance-benchmark-2018-mongodb-postgresql-orientdb-neo4j-arangodb/)。自己本来对图数据库也很感兴趣，在reddit上看到了[对这个测试的讨论]()。自己本来对图数据库也很感兴趣，就想要参考这个测试自己来做一些深入的学习和研究。

现在先对图数据库进行一些基本的了解和认知。

### 图数据库是什么
维基百科的定义是这样的：

但是其实我们更关注的是工程上的应用了。图数据库核心是图模型，图模型实现的是图论的基本原理和基于图论的数据结构和算法，包括图的遍历和最短路径问题等，在实际应用中可以在社交网络，路径规划等项目中发挥作用。

另外，在实现Graph数据模型时候往往也会实现一些类似的数据模型，比如Document, Key-Value, RDF(知识图谱模型是一个有趣新颖的模型，在互联网维度越来越广的领域会发挥越来越大的作用)。因为这几个模型在实现上相互关联的，所以在实际工程中这些模型也可以做了考虑的因素。

### 几种主流图数据库
参考这个测试，加上自己平时对图数据库的关注。我选择了几个自己比较熟悉有相对主流的图数据库：

1. arangodb -- 一直在关注的图数据库
2. neo4j -- 目前使用最广的图数据库
3. orientdb -- 很主流的数据库，并且跟titan很像
4. agensgraph -- 很好玩，完全基于postgre增加graph的功能
5. mongodb -- 本身其实不是图数据库，但是因为是很成熟的文档型数据库，并且文档模型跟图模型设计上会有很多相似地方，有很多可以比较的地方。

**其实还有一个titan也很热门，由于好几年没有更新了，所以就没有持续关注了。**

GraphDB	    |查询语言	    	        |存储引擎	                                                |模型			    |开发语言
---	        |---	                    |---	                                                    |---	            |---
Arangodb	|AQL	                    |rocksdb\mmfiles	                                        |multi-model	    |c++
neo4j	    |cypher	            	    |non-native graph storage                                   |graph	            |java
orientdb	|OrientDB SQL	    	    |plocal Paginated Local storage engine	                    |multi-model	    |java
agensgraph	|ANSI-SQL and openCypher 	|postgre	        	                                    |multi-model	    |c
mongodb	    |mongodb CRUD	            |WiredTiger Storage Engine\In-Memory Storage Engine\MMAPv1 	|document	        |c++

#### 查询语言

[AQL](https://www.arangodb.com/wp-content/uploads/2016/05/shell-reference-card.pdf)：ArangoDB自己定义的查询语言，由于是文档模型上设计的图模型因此很多语法都跟文档相关，有collection,document,edge的概念，文档的模式跟mongodb类似

Orient SQL: 这个语法更接近SQL，但是也做了类似cypher的MATCH语法。 
[Cypher](http://www.opencypher.org): neo4j定义出来的一个想要成为图数据库标准的图模型描述语言，现在也比较受业界认可，除了neo4j之外，agensgraph也是在PostgreSQL是实现了cypher语法，另外也和databricks合作，将cypher在spark上集成了。

下面这是在cypher官网截的一个cypher查询语句：

```
     MATCH (d:Database)-[:USES]->(Cypher)-[:QUERIES]->(:Model:Graph)
     WHERE d.name IN ['SAP HANA Graph','Redis','AgensGraph', 'Neo4j',...]
     RETURN Cypher.features
```


```
    SELECT name, out('ACTS').title FROM Person WHERE name = 'Robin'
    MATCH {class:Person, as:actor, where:(name:'Robin'))-ACTS_IN-> {as:movie}
    RETURN actor.name, movie.title
```

MongoDB CRUD: mongodb是文档数据库，其主要概念就是collection和document，crud操作也是基于这两个概念，并且由于文档直接的关联概念比较小，不像图模型中处处存在联系，因此关联查询那块比较弱，也不会主要有MATCH那个概念。

#### 存储引擎

ArangoDB使用了MMFiles和RocksDB两种存储引擎，RocksDB是在新的版本中添加进来，并且将此设为了默认存储引擎

OrientDB
