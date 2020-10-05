# About docker-fop

This is the Git repo for the Docker image [chrwahl/fop](https://hub.docker.com/r/chrwahl/fop) — a Docker image for running [Apache™ FOP](https://xmlgraphics.apache.org/fop/).

You can either build your own Docker image or you can pull the image from Docker Hub.

Build an image from the Docker file:

```
docker build -t fop .

```
Pull the image from Docker Hub:
```
docker pull chrwahl/fop
```
If you build your own image you can replace "chrwahl/fop" with "fop" in the following commands.

## How to use this image

Return the version of Apache™ FOP:

```
$ docker run -it --rm chrwahl/fop
```

### Generate PDF from a XSL-FO document

The [XSL-FO](https://www.w3.org/TR/xsl/#fo-section) document is a XML document with the namespace `http://www.w3.org/1999/XSL/Format`.

A basic example:

```
<?xml version="1.0" encoding="UTF-8"?>
<root xmlns="http://www.w3.org/1999/XSL/Format">
  <layout-master-set>
    <simple-page-master margin="10mm" page-width="210mm" page-height="297mm" master-name="simple">
      <region-body region-name="simple-body" margin-bottom="20mm" margin-top="20mm" />
    </simple-page-master>
  </layout-master-set>
  <page-sequence master-reference="simple">
    <flow flow-name="simple-body">
      <block>Hello World!</block>
    </flow>
  </page-sequence>
</root>
```
With the above XSL-FO document saved as `helloworld.fo`, run the following command to genereate a PDF file:

```
docker run --user $(id -u):$(id -g) -v $(pwd):/src -w /src -it --rm chrwahl/fop helloworld.fo -pdf helloworld.pdf
```
### Generate PDF from XML and XSL

A XSL-FO document can also be generated on the fly in a XSL Transformation.

Given the following XML document:

```
<?xml version="1.0" encoding="UTF-8"?>
<data>
  <par>Hello World!</par>
</data>
```
And the following XSL document:
```
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:template match="data">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <fo:layout-master-set>
        <fo:simple-page-master margin="10mm" page-width="210mm" page-height="297mm" master-name="simple">
          <fo:region-body region-name="simple-body" margin-bottom="20mm" margin-top="20mm" />
        </fo:simple-page-master>
      </fo:layout-master-set>
      <fo:page-sequence master-reference="simple">
        <fo:flow flow-name="simple-body">
          <xsl:apply-templates />
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
  <xsl:template match="par">
    <fo:block>
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>
</xsl:stylesheet>
```
A PDF can be gerated with this command:

```
$ docker run --user $(id -u):$(id -g) -v $(pwd):/src -w /src -it --rm chrwahl/fop -xml helloworld.xml -xsl helloword.xslt -pdf document.pdf
```

To simplify the command the user flag (`--user $(id -u):$(id -g)`) can be omitted and `$(pwd)` can be replaced with the absolute path to the working directory.

## Documentation

More information about the FOP project: [https://xmlgraphics.apache.org/fop/](https://xmlgraphics.apache.org/fop/)