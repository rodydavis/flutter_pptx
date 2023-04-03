/// This file is generated, do not edit!
/// See `bin/copy.dart` for more information.

/// Path: ./template/ppt/slides/photo_3_up.xml.mustache
const String template = r'''<?xml version="1.0" encoding="UTF-8"?>
<p:sld xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
    xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main"
    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
    xmlns:a14="http://schemas.microsoft.com/office/drawing/2010/main" showMasterSp="1" showMasterPhAnim="1">
    <p:cSld>
        {{>slide-background}}
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
            <p:pic>
                <p:nvPicPr>
                    {{#image1}}
                    <p:cNvPr id="{{new-id}}" name="{{image1.name}}" descr="{{image1.description}}"/>
                    {{/image1}}
                    {{^image1}}
                    <p:cNvPr id="{{new-id}}" name="Image 1" descr="Image 1"/>
                    {{/image1}}
                    <p:cNvPicPr>
                        <a:picLocks noChangeAspect="1"/>
                    </p:cNvPicPr>
                    <p:nvPr>
                        <p:ph type="pic" idx="21"/>
                    </p:nvPr>
                </p:nvPicPr>
                <p:blipFill>
                    <a:blip r:embed="rId{{imageId1}}">
                        <a:extLst/>
                    </a:blip>
                    <a:stretch>
                        <a:fillRect/>
                    </a:stretch>
                </p:blipFill>
                <p:spPr>
                    <a:prstGeom prst="rect">
                        <a:avLst/>
                    </a:prstGeom>
                </p:spPr>
            </p:pic>
            <p:pic>
                <p:nvPicPr>
                    {{#image2}}
                    <p:cNvPr id="{{new-id}}" name="{{image2.name}}" descr="{{image2.description}}"/>
                    {{/image2}}
                    {{^image2}}
                    <p:cNvPr id="{{new-id}}" name="Image 2" descr="Image 2"/>
                    {{/image2}}
                    <p:cNvPicPr>
                        <a:picLocks noChangeAspect="1"/>
                    </p:cNvPicPr>
                    <p:nvPr>
                        <p:ph type="pic" idx="22"/>
                    </p:nvPr>
                </p:nvPicPr>
                <p:blipFill>
                    <a:blip r:embed="rId{{imageId2}}">
                        <a:extLst/>
                    </a:blip>
                    <a:stretch>
                        <a:fillRect/>
                    </a:stretch>
                </p:blipFill>
                <p:spPr>
                    <a:prstGeom prst="rect">
                        <a:avLst/>
                    </a:prstGeom>
                </p:spPr>
            </p:pic>
            <p:pic>
                <p:nvPicPr>
                    {{#image3}}
                    <p:cNvPr id="{{new-id}}" name="{{image3.name}}" descr="{{image3.description}}"/>
                    {{/image3}}
                    {{^image3}}
                    <p:cNvPr id="{{new-id}}" name="Image 3" descr="Image 3"/>
                    {{/image3}}
                    <p:cNvPicPr>
                        <a:picLocks noChangeAspect="1"/>
                    </p:cNvPicPr>
                    <p:nvPr>
                        <p:ph type="pic" idx="23"/>
                    </p:nvPr>
                </p:nvPicPr>
                <p:blipFill>
                    <a:blip r:embed="rId{{imageId3}}">
                        <a:extLst/>
                    </a:blip>
                    <a:stretch>
                        <a:fillRect/>
                    </a:stretch>
                </p:blipFill>
                <p:spPr>
                    <a:prstGeom prst="rect">
                        <a:avLst/>
                    </a:prstGeom>
                </p:spPr>
            </p:pic>
            {{>speaker-notes}}
        </p:spTree>
    </p:cSld>
    <p:clrMapOvr>
        <a:masterClrMapping/>
    </p:clrMapOvr>
    <p:transition xmlns:p14="http://schemas.microsoft.com/office/powerpoint/2010/main" spd="med" advClick="1"/>
</p:sld>''';
