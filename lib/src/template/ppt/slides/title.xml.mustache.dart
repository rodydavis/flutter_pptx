/// This file is generated, do not edit!
/// See `bin/copy.dart` for more information.

/// Path: ./template/ppt/slides/title.xml.mustache
const String template = r'''<?xml version="1.0" encoding="UTF-8"?>
<p:sld xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
    xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main"
    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
    xmlns:a14="http://schemas.microsoft.com/office/drawing/2010/main" showMasterSp="1" showMasterPhAnim="1">
    <p:cSld>
        <p:spTree>
            <p:nvGrpSpPr>
                <p:cNvPr id="1" name=""/>
                <p:cNvGrpSpPr/>
                <p:nvPr/>
            </p:nvGrpSpPr>
            <p:grpSpPr>
                <a:xfrm>
                    <a:off x="0" y="0"/>
                    <a:ext cx="0" cy="0"/>
                    <a:chOff x="0" y="0"/>
                    <a:chExt cx="0" cy="0"/>
                </a:xfrm>
            </p:grpSpPr>
            <p:sp>
                <p:nvSpPr>
                    <p:cNvPr id="{{id1}}" name="Author and Date"/>
                    <p:cNvSpPr txBox="1"/>
                    <p:nvPr>
                        <p:ph type="body" sz="quarter" idx="1"/>
                    </p:nvPr>
                </p:nvSpPr>
                <p:spPr>
                    <a:xfrm>
                        <a:off x="1219199" y="11986162"/>
                        <a:ext cx="21945600" cy="605792"/>
                    </a:xfrm>
                    <a:prstGeom prst="rect">
                        <a:avLst/>
                    </a:prstGeom>
                </p:spPr>
                <p:txBody>
                    <a:bodyPr/>
                    <a:lstStyle/>
                    <a:p>
                        <a:pPr/>
                        {{#author}}
                        <a:r>
                            <a:t>{{author}}</a:t>
                        </a:r>
                        {{/author}}}
                    </a:p>
                </p:txBody>
            </p:sp>
            <p:sp>
                <p:nvSpPr>
                    <p:cNvPr id="{{id2}}" name="Presentation Title"/>
                    <p:cNvSpPr txBox="1"/>
                    <p:nvPr>
                        <p:ph type="title"/>
                    </p:nvPr>
                </p:nvSpPr>
                <p:spPr>
                    <a:prstGeom prst="rect">
                        <a:avLst/>
                    </a:prstGeom>
                </p:spPr>
                <p:txBody>
                    <a:bodyPr/>
                    <a:lstStyle/>
                    <a:p>
                        <a:pPr/>
                        {{#title}}}
                        <a:r>
                            <a:t>{{title}}</a:t>
                        </a:r>
                        {{/title}}
                    </a:p>
                </p:txBody>
            </p:sp>
            {{#slideNumber}}
            <p:sp>
                <p:nvSpPr>
                    <p:cNvPr id="{{id3}}" name="Slide Number"/>
                    <p:cNvSpPr txBox="1"/>
                    <p:nvPr>
                        <p:ph type="sldNum" sz="quarter" idx="2"/>
                    </p:nvPr>
                </p:nvSpPr>
                <p:spPr>
                    <a:xfrm>
                        <a:off x="12087986" y="12700001"/>
                        <a:ext cx="215647" cy="429261"/>
                    </a:xfrm>
                    <a:prstGeom prst="rect">
                        <a:avLst/>
                    </a:prstGeom>
                    <a:extLst>
                        <a:ext uri="{C572A759-6A51-4108-AA02-DFA0A04FC94B}">
                            <ma14:wrappingTextBoxFlag val="1"
                                xmlns:ma14="http://schemas.microsoft.com/office/mac/drawingml/2011/main"/>
                        </a:ext>
                    </a:extLst>
                </p:spPr>
                <p:txBody>
                    <a:bodyPr/>
                    <a:lstStyle/>
                    <a:p>
                        <a:pPr/>
                        <a:fld id="{86CB4B4D-7CA3-9044-876B-883B54F8677D}" type="slidenum"/>
                    </a:p>
                </p:txBody>
            </p:sp>
            {{/slideNumber}}
        </p:spTree>
    </p:cSld>
    <p:clrMapOvr>
        <a:masterClrMapping/>
    </p:clrMapOvr>
    <p:transition xmlns:p14="http://schemas.microsoft.com/office/powerpoint/2010/main" spd="med" advClick="1"/>
</p:sld>''';