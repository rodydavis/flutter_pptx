/// This file is generated, do not edit!
/// See `bin/copy.dart` for more information.

/// Path: ./template/ppt/presentation.xml.mustache
const String template = r'''<?xml version="1.0" encoding="UTF-8"?>
<p:presentation xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
    xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
    xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main"
    xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
    xmlns:a14="http://schemas.microsoft.com/office/drawing/2010/main">
    <p:sldMasterIdLst>
        <p:sldMasterId id="2147483648" r:id="rId5"/>
    </p:sldMasterIdLst>
    <p:notesMasterIdLst>
        <p:notesMasterId r:id="rId7"/>
    </p:notesMasterIdLst>
    <p:sldIdLst>
    {{#slides}}
        <p:sldId id="{{id}}" r:id="rId{{rId}}"/>
    {{/slides}}
    </p:sldIdLst>
    {{#layout}}
    <p:sldSz cx="{{width}}" cy="{{height}}" type="{{type}}"/>
    {{/layout}}         
    <p:notesSz cx="6858000" cy="9144000"/>
    <p:defaultTextStyle>
        <a:defPPr marL="0" marR="0" indent="0" algn="l" defTabSz="914400" rtl="0" fontAlgn="auto" latinLnBrk="1" hangingPunct="0">
            <a:lnSpc>
                <a:spcPct val="100000"/>
            </a:lnSpc>
            <a:spcBef>
                <a:spcPts val="0"/>
            </a:spcBef>
            <a:spcAft>
                <a:spcPts val="0"/>
            </a:spcAft>
            <a:buClrTx/>
            <a:buSzTx/>
            <a:buFontTx/>
            <a:buNone/>
            <a:tabLst/>
            <a:defRPr b="0" baseline="0" cap="none" i="0" spc="0" strike="noStrike" sz="1800" u="none" kumimoji="0" normalizeH="0">
                <a:ln>
                    <a:noFill/>
                </a:ln>
                <a:solidFill>
                    <a:srgbClr val="000000"/>
                </a:solidFill>
                <a:effectLst/>
                <a:uFillTx/>
            </a:defRPr>
        </a:defPPr>
        <a:lvl1pPr marL="0" marR="0" indent="0" algn="ctr" defTabSz="2438400" rtl="0" fontAlgn="auto" latinLnBrk="0" hangingPunct="0">
            <a:lnSpc>
                <a:spcPct val="90000"/>
            </a:lnSpc>
            <a:spcBef>
                <a:spcPts val="0"/>
            </a:spcBef>
            <a:spcAft>
                <a:spcPts val="0"/>
            </a:spcAft>
            <a:buClrTx/>
            <a:buSzTx/>
            <a:buFontTx/>
            <a:buNone/>
            <a:tabLst/>
            <a:defRPr b="0" baseline="0" cap="none" i="0" spc="0" strike="noStrike" sz="2400" u="none" kumimoji="0" normalizeH="0">
                <a:ln>
                    <a:noFill/>
                </a:ln>
                <a:solidFill>
                    <a:srgbClr val="000000"/>
                </a:solidFill>
                <a:effectLst/>
                <a:uFillTx/>
                <a:latin typeface="Canela Bold"/>
                <a:ea typeface="Canela Bold"/>
                <a:cs typeface="Canela Bold"/>
                <a:sym typeface="Canela Bold"/>
            </a:defRPr>
        </a:lvl1pPr>
        <a:lvl2pPr marL="0" marR="0" indent="0" algn="ctr" defTabSz="2438400" rtl="0" fontAlgn="auto" latinLnBrk="0" hangingPunct="0">
            <a:lnSpc>
                <a:spcPct val="90000"/>
            </a:lnSpc>
            <a:spcBef>
                <a:spcPts val="0"/>
            </a:spcBef>
            <a:spcAft>
                <a:spcPts val="0"/>
            </a:spcAft>
            <a:buClrTx/>
            <a:buSzTx/>
            <a:buFontTx/>
            <a:buNone/>
            <a:tabLst/>
            <a:defRPr b="0" baseline="0" cap="none" i="0" spc="0" strike="noStrike" sz="2400" u="none" kumimoji="0" normalizeH="0">
                <a:ln>
                    <a:noFill/>
                </a:ln>
                <a:solidFill>
                    <a:srgbClr val="000000"/>
                </a:solidFill>
                <a:effectLst/>
                <a:uFillTx/>
                <a:latin typeface="Canela Bold"/>
                <a:ea typeface="Canela Bold"/>
                <a:cs typeface="Canela Bold"/>
                <a:sym typeface="Canela Bold"/>
            </a:defRPr>
        </a:lvl2pPr>
        <a:lvl3pPr marL="0" marR="0" indent="0" algn="ctr" defTabSz="2438400" rtl="0" fontAlgn="auto" latinLnBrk="0" hangingPunct="0">
            <a:lnSpc>
                <a:spcPct val="90000"/>
            </a:lnSpc>
            <a:spcBef>
                <a:spcPts val="0"/>
            </a:spcBef>
            <a:spcAft>
                <a:spcPts val="0"/>
            </a:spcAft>
            <a:buClrTx/>
            <a:buSzTx/>
            <a:buFontTx/>
            <a:buNone/>
            <a:tabLst/>
            <a:defRPr b="0" baseline="0" cap="none" i="0" spc="0" strike="noStrike" sz="2400" u="none" kumimoji="0" normalizeH="0">
                <a:ln>
                    <a:noFill/>
                </a:ln>
                <a:solidFill>
                    <a:srgbClr val="000000"/>
                </a:solidFill>
                <a:effectLst/>
                <a:uFillTx/>
                <a:latin typeface="Canela Bold"/>
                <a:ea typeface="Canela Bold"/>
                <a:cs typeface="Canela Bold"/>
                <a:sym typeface="Canela Bold"/>
            </a:defRPr>
        </a:lvl3pPr>
        <a:lvl4pPr marL="0" marR="0" indent="0" algn="ctr" defTabSz="2438400" rtl="0" fontAlgn="auto" latinLnBrk="0" hangingPunct="0">
            <a:lnSpc>
                <a:spcPct val="90000"/>
            </a:lnSpc>
            <a:spcBef>
                <a:spcPts val="0"/>
            </a:spcBef>
            <a:spcAft>
                <a:spcPts val="0"/>
            </a:spcAft>
            <a:buClrTx/>
            <a:buSzTx/>
            <a:buFontTx/>
            <a:buNone/>
            <a:tabLst/>
            <a:defRPr b="0" baseline="0" cap="none" i="0" spc="0" strike="noStrike" sz="2400" u="none" kumimoji="0" normalizeH="0">
                <a:ln>
                    <a:noFill/>
                </a:ln>
                <a:solidFill>
                    <a:srgbClr val="000000"/>
                </a:solidFill>
                <a:effectLst/>
                <a:uFillTx/>
                <a:latin typeface="Canela Bold"/>
                <a:ea typeface="Canela Bold"/>
                <a:cs typeface="Canela Bold"/>
                <a:sym typeface="Canela Bold"/>
            </a:defRPr>
        </a:lvl4pPr>
        <a:lvl5pPr marL="0" marR="0" indent="0" algn="ctr" defTabSz="2438400" rtl="0" fontAlgn="auto" latinLnBrk="0" hangingPunct="0">
            <a:lnSpc>
                <a:spcPct val="90000"/>
            </a:lnSpc>
            <a:spcBef>
                <a:spcPts val="0"/>
            </a:spcBef>
            <a:spcAft>
                <a:spcPts val="0"/>
            </a:spcAft>
            <a:buClrTx/>
            <a:buSzTx/>
            <a:buFontTx/>
            <a:buNone/>
            <a:tabLst/>
            <a:defRPr b="0" baseline="0" cap="none" i="0" spc="0" strike="noStrike" sz="2400" u="none" kumimoji="0" normalizeH="0">
                <a:ln>
                    <a:noFill/>
                </a:ln>
                <a:solidFill>
                    <a:srgbClr val="000000"/>
                </a:solidFill>
                <a:effectLst/>
                <a:uFillTx/>
                <a:latin typeface="Canela Bold"/>
                <a:ea typeface="Canela Bold"/>
                <a:cs typeface="Canela Bold"/>
                <a:sym typeface="Canela Bold"/>
            </a:defRPr>
        </a:lvl5pPr>
        <a:lvl6pPr marL="0" marR="0" indent="0" algn="ctr" defTabSz="2438400" rtl="0" fontAlgn="auto" latinLnBrk="0" hangingPunct="0">
            <a:lnSpc>
                <a:spcPct val="90000"/>
            </a:lnSpc>
            <a:spcBef>
                <a:spcPts val="0"/>
            </a:spcBef>
            <a:spcAft>
                <a:spcPts val="0"/>
            </a:spcAft>
            <a:buClrTx/>
            <a:buSzTx/>
            <a:buFontTx/>
            <a:buNone/>
            <a:tabLst/>
            <a:defRPr b="0" baseline="0" cap="none" i="0" spc="0" strike="noStrike" sz="2400" u="none" kumimoji="0" normalizeH="0">
                <a:ln>
                    <a:noFill/>
                </a:ln>
                <a:solidFill>
                    <a:srgbClr val="000000"/>
                </a:solidFill>
                <a:effectLst/>
                <a:uFillTx/>
                <a:latin typeface="Canela Bold"/>
                <a:ea typeface="Canela Bold"/>
                <a:cs typeface="Canela Bold"/>
                <a:sym typeface="Canela Bold"/>
            </a:defRPr>
        </a:lvl6pPr>
        <a:lvl7pPr marL="0" marR="0" indent="0" algn="ctr" defTabSz="2438400" rtl="0" fontAlgn="auto" latinLnBrk="0" hangingPunct="0">
            <a:lnSpc>
                <a:spcPct val="90000"/>
            </a:lnSpc>
            <a:spcBef>
                <a:spcPts val="0"/>
            </a:spcBef>
            <a:spcAft>
                <a:spcPts val="0"/>
            </a:spcAft>
            <a:buClrTx/>
            <a:buSzTx/>
            <a:buFontTx/>
            <a:buNone/>
            <a:tabLst/>
            <a:defRPr b="0" baseline="0" cap="none" i="0" spc="0" strike="noStrike" sz="2400" u="none" kumimoji="0" normalizeH="0">
                <a:ln>
                    <a:noFill/>
                </a:ln>
                <a:solidFill>
                    <a:srgbClr val="000000"/>
                </a:solidFill>
                <a:effectLst/>
                <a:uFillTx/>
                <a:latin typeface="Canela Bold"/>
                <a:ea typeface="Canela Bold"/>
                <a:cs typeface="Canela Bold"/>
                <a:sym typeface="Canela Bold"/>
            </a:defRPr>
        </a:lvl7pPr>
        <a:lvl8pPr marL="0" marR="0" indent="0" algn="ctr" defTabSz="2438400" rtl="0" fontAlgn="auto" latinLnBrk="0" hangingPunct="0">
            <a:lnSpc>
                <a:spcPct val="90000"/>
            </a:lnSpc>
            <a:spcBef>
                <a:spcPts val="0"/>
            </a:spcBef>
            <a:spcAft>
                <a:spcPts val="0"/>
            </a:spcAft>
            <a:buClrTx/>
            <a:buSzTx/>
            <a:buFontTx/>
            <a:buNone/>
            <a:tabLst/>
            <a:defRPr b="0" baseline="0" cap="none" i="0" spc="0" strike="noStrike" sz="2400" u="none" kumimoji="0" normalizeH="0">
                <a:ln>
                    <a:noFill/>
                </a:ln>
                <a:solidFill>
                    <a:srgbClr val="000000"/>
                </a:solidFill>
                <a:effectLst/>
                <a:uFillTx/>
                <a:latin typeface="Canela Bold"/>
                <a:ea typeface="Canela Bold"/>
                <a:cs typeface="Canela Bold"/>
                <a:sym typeface="Canela Bold"/>
            </a:defRPr>
        </a:lvl8pPr>
        <a:lvl9pPr marL="0" marR="0" indent="0" algn="ctr" defTabSz="2438400" rtl="0" fontAlgn="auto" latinLnBrk="0" hangingPunct="0">
            <a:lnSpc>
                <a:spcPct val="90000"/>
            </a:lnSpc>
            <a:spcBef>
                <a:spcPts val="0"/>
            </a:spcBef>
            <a:spcAft>
                <a:spcPts val="0"/>
            </a:spcAft>
            <a:buClrTx/>
            <a:buSzTx/>
            <a:buFontTx/>
            <a:buNone/>
            <a:tabLst/>
            <a:defRPr b="0" baseline="0" cap="none" i="0" spc="0" strike="noStrike" sz="2400" u="none" kumimoji="0" normalizeH="0">
                <a:ln>
                    <a:noFill/>
                </a:ln>
                <a:solidFill>
                    <a:srgbClr val="000000"/>
                </a:solidFill>
                <a:effectLst/>
                <a:uFillTx/>
                <a:latin typeface="Canela Bold"/>
                <a:ea typeface="Canela Bold"/>
                <a:cs typeface="Canela Bold"/>
                <a:sym typeface="Canela Bold"/>
            </a:defRPr>
        </a:lvl9pPr>
    </p:defaultTextStyle>
</p:presentation>''';
