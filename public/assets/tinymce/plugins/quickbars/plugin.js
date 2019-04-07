/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.0.3 (2019-03-19)
 */
!function(t){"use strict";var e,n,r,o,i=tinymce.util.Tools.resolve("tinymce.PluginManager"),a=0,u=function(e,n,r){var t,o,i;e.plugins.table?e.plugins.table.insertTable(n,r):(o=n,i=r,(t=e).undoManager.transact(function(){var e,n;t.insertContent(function(e,n){var r,t,o;for(o='<table data-mce-id="mce" style="width: 100%">',o+="<tbody>",t=0;t<n;t++){for(o+="<tr>",r=0;r<e;r++)o+="<td><br></td>";o+="</tr>"}return o+="</tbody>",o+="</table>"}(o,i)),(e=t.dom.select("*[data-mce-id]")[0]).removeAttribute("data-mce-id"),n=t.dom.select("td,th",e),t.selection.setCursorLocation(n[0],0)}))},s=function(e,n,r){var t,o,i,u;o=(t=e.editorUpload.blobCache).create((i="mceu",u=(new Date).getTime(),i+"_"+Math.floor(1e9*Math.random())+ ++a+String(u)),r,n),t.add(o),e.insertContent(e.dom.createHTML("img",{src:o.blobUri()}))},c="undefined"!=typeof t.window?t.window:Function("return this;")(),f=function(e,n){return function(e,n){for(var r=n!==undefined&&null!==n?n:c,t=0;t<e.length&&r!==undefined&&null!==r;++t)r=r[e[t]];return r}(e.split("."),n)},d=function(e,n){var r=f(e,n);if(r===undefined||null===r)throw e+" not available on this browser";return r},l=tinymce.util.Tools.resolve("tinymce.util.Promise"),m=function(t){return new l(function(e){var n=function r(){return new(d("FileReader"))}();n.onloadend=function(){e(n.result.split(",")[1])},n.readAsDataURL(t)})},g=function(){return new l(function(n){var e;(e=t.document.createElement("input")).type="file",e.style.position="fixed",e.style.left=0,e.style.top=0,e.style.opacity=.001,t.document.body.appendChild(e),e.onchange=function(e){n(Array.prototype.slice.call(e.target.files))},e.click(),e.parentNode.removeChild(e)})},h=function(r){r.ui.registry.addButton("quickimage",{icon:"image",tooltip:"Insert image",onAction:function(){g().then(function(e){var n=e[0];m(n).then(function(e){s(r,e,n)})})}}),r.ui.registry.addButton("quicktable",{icon:"table",tooltip:"Insert table",onAction:function(){u(r,2,2)}})},v=function(e){return function(){return e}},p=v(!1),b=v(!0),O=p,N=b,w=function(){return E},E=(o={fold:function(e,n){return e()},is:O,isSome:O,isNone:N,getOr:r=function(e){return e},getOrThunk:n=function(e){return e()},getOrDie:function(e){throw new Error(e||"error: getOrDie called on none.")},getOrNull:function(){return null},getOrUndefined:function(){return undefined},or:r,orThunk:n,map:w,ap:w,each:function(){},bind:w,flatten:w,exists:O,forall:N,filter:w,equals:e=function(e){return e.isNone()},equals_:e,toArray:function(){return[]},toString:v("none()")},Object.freeze&&Object.freeze(o),o),T=function(r){var e=function(){return r},n=function(){return o},t=function(e){return e(r)},o={fold:function(e,n){return n(r)},is:function(e){return r===e},isSome:N,isNone:O,getOr:e,getOrThunk:e,getOrDie:e,getOrNull:e,getOrUndefined:e,or:n,orThunk:n,map:function(e){return T(e(r))},ap:function(e){return e.fold(w,function(e){return T(e(r))})},each:function(e){e(r)},bind:t,flatten:e,exists:t,forall:t,filter:function(e){return e(r)?o:E},equals:function(e){return e.is(r)},equals_:function(e,n){return e.fold(O,function(e){return n(r,e)})},toArray:function(){return[r]},toString:function(){return"some("+r+")"}};return o},S={some:T,none:w,from:function(e){return null===e||e===undefined?E:T(e)}},x=function(e){if(null===e||e===undefined)throw new Error("Node cannot be null or undefined");return{dom:v(e)}},y={fromHtml:function(e,n){var r=(n||t.document).createElement("div");if(r.innerHTML=e,!r.hasChildNodes()||1<r.childNodes.length)throw t.console.error("HTML does not have a single root node",e),new Error("HTML must have a single root node");return x(r.childNodes[0])},fromTag:function(e,n){var r=(n||t.document).createElement(e);return x(r)},fromText:function(e,n){var r=(n||t.document).createTextNode(e);return x(r)},fromDom:x,fromPoint:function(e,n,r){var t=e.dom();return S.from(t.elementFromPoint(n,r)).map(x)}},k=(t.Node.ATTRIBUTE_NODE,t.Node.CDATA_SECTION_NODE,t.Node.COMMENT_NODE,t.Node.DOCUMENT_NODE,t.Node.DOCUMENT_TYPE_NODE,t.Node.DOCUMENT_FRAGMENT_NODE,t.Node.ELEMENT_NODE),D=(t.Node.TEXT_NODE,t.Node.PROCESSING_INSTRUCTION_NODE,t.Node.ENTITY_REFERENCE_NODE,t.Node.ENTITY_NODE,t.Node.NOTATION_NODE,function(n){return function(e){return function(e){if(null===e)return"null";var n=typeof e;return"object"===n&&Array.prototype.isPrototypeOf(e)?"array":"object"===n&&String.prototype.isPrototypeOf(e)?"string":n}(e)===n}}),_=D("string"),C=D("object"),A=D("array"),R=D("boolean"),M=D("undefined"),I=D("function");Array.prototype.slice;function q(e,n,r,t,o){return e(r,t)?S.some(r):I(o)&&o(r)?S.none():n(r,t,o)}I(Array.from)&&Array.from;var L,F,P,U,j=function(e,n){var r=function(e,n){for(var r=0;r<e.length;r++){var t=e[r];if(t.test(n))return t}return undefined}(e,n);if(!r)return{major:0,minor:0};var t=function(e){return Number(n.replace(r,"$"+e))};return H(t(1),t(2))},B=function(){return H(0,0)},H=function(e,n){return{major:e,minor:n}},X={nu:H,detect:function(e,n){var r=String(n).toLowerCase();return 0===e.length?B():j(e,r)},unknown:B},z="Firefox",G=function(e,n){return function(){return n===e}},W=function(e){var n=e.current;return{current:n,version:e.version,isEdge:G("Edge",n),isChrome:G("Chrome",n),isIE:G("IE",n),isOpera:G("Opera",n),isFirefox:G(z,n),isSafari:G("Safari",n)}},Y={unknown:function(){return W({current:undefined,version:X.unknown()})},nu:W,edge:v("Edge"),chrome:v("Chrome"),ie:v("IE"),opera:v("Opera"),firefox:v(z),safari:v("Safari")},$="Windows",V="Android",J="Solaris",K="FreeBSD",Q=function(e,n){return function(){return n===e}},Z=function(e){var n=e.current;return{current:n,version:e.version,isWindows:Q($,n),isiOS:Q("iOS",n),isAndroid:Q(V,n),isOSX:Q("OSX",n),isLinux:Q("Linux",n),isSolaris:Q(J,n),isFreeBSD:Q(K,n)}},ee={unknown:function(){return Z({current:undefined,version:X.unknown()})},nu:Z,windows:v($),ios:v("iOS"),android:v(V),linux:v("Linux"),osx:v("OSX"),solaris:v(J),freebsd:v(K)},ne=function(e,n){var r=String(n).toLowerCase();return function(e,n){for(var r=0,t=e.length;r<t;r++){var o=e[r];if(n(o,r,e))return S.some(o)}return S.none()}(e,function(e){return e.search(r)})},re=function(e,r){return ne(e,r).map(function(e){var n=X.detect(e.versionRegexes,r);return{current:e.name,version:n}})},te=function(e,r){return ne(e,r).map(function(e){var n=X.detect(e.versionRegexes,r);return{current:e.name,version:n}})},oe=function(e,n){return-1!==e.indexOf(n)},ie=/.*?version\/\ ?([0-9]+)\.([0-9]+).*/,ue=function(n){return function(e){return oe(e,n)}},ae=[{name:"Edge",versionRegexes:[/.*?edge\/ ?([0-9]+)\.([0-9]+)$/],search:function(e){return oe(e,"edge/")&&oe(e,"chrome")&&oe(e,"safari")&&oe(e,"applewebkit")}},{name:"Chrome",versionRegexes:[/.*?chrome\/([0-9]+)\.([0-9]+).*/,ie],search:function(e){return oe(e,"chrome")&&!oe(e,"chromeframe")}},{name:"IE",versionRegexes:[/.*?msie\ ?([0-9]+)\.([0-9]+).*/,/.*?rv:([0-9]+)\.([0-9]+).*/],search:function(e){return oe(e,"msie")||oe(e,"trident")}},{name:"Opera",versionRegexes:[ie,/.*?opera\/([0-9]+)\.([0-9]+).*/],search:ue("opera")},{name:"Firefox",versionRegexes:[/.*?firefox\/\ ?([0-9]+)\.([0-9]+).*/],search:ue("firefox")},{name:"Safari",versionRegexes:[ie,/.*?cpu os ([0-9]+)_([0-9]+).*/],search:function(e){return(oe(e,"safari")||oe(e,"mobile/"))&&oe(e,"applewebkit")}}],se=[{name:"Windows",search:ue("win"),versionRegexes:[/.*?windows\ nt\ ?([0-9]+)\.([0-9]+).*/]},{name:"iOS",search:function(e){return oe(e,"iphone")||oe(e,"ipad")},versionRegexes:[/.*?version\/\ ?([0-9]+)\.([0-9]+).*/,/.*cpu os ([0-9]+)_([0-9]+).*/,/.*cpu iphone os ([0-9]+)_([0-9]+).*/]},{name:"Android",search:ue("android"),versionRegexes:[/.*?android\ ?([0-9]+)\.([0-9]+).*/]},{name:"OSX",search:ue("os x"),versionRegexes:[/.*?os\ x\ ?([0-9]+)_([0-9]+).*/]},{name:"Linux",search:ue("linux"),versionRegexes:[]},{name:"Solaris",search:ue("sunos"),versionRegexes:[]},{name:"FreeBSD",search:ue("freebsd"),versionRegexes:[]}],ce={browsers:v(ae),oses:v(se)},fe=function(e){var n,r,t,o,i,u,a,s,c,f,d,l=ce.browsers(),m=ce.oses(),g=re(l,e).fold(Y.unknown,Y.nu),h=te(m,e).fold(ee.unknown,ee.nu);return{browser:g,os:h,deviceType:(r=g,t=e,o=(n=h).isiOS()&&!0===/ipad/i.test(t),i=n.isiOS()&&!o,u=n.isAndroid()&&3===n.version.major,a=n.isAndroid()&&4===n.version.major,s=o||u||a&&!0===/mobile/i.test(t),c=n.isiOS()||n.isAndroid(),f=c&&!s,d=r.isSafari()&&n.isiOS()&&!1===/safari/i.test(t),{isiPad:v(o),isiPhone:v(i),isTablet:v(s),isPhone:v(f),isTouch:v(c),isAndroid:n.isAndroid,isiOS:n.isiOS,isWebView:v(d)})}},de=(P=!(L=function(){var e=t.navigator.userAgent;return fe(e)}),function(){for(var e=[],n=0;n<arguments.length;n++)e[n]=arguments[n];return P||(P=!0,F=L.apply(null,e)),F}),le=k,me=function(e,n){var r=e.dom();if(r.nodeType!==le)return!1;if(r.matches!==undefined)return r.matches(n);if(r.msMatchesSelector!==undefined)return r.msMatchesSelector(n);if(r.webkitMatchesSelector!==undefined)return r.webkitMatchesSelector(n);if(r.mozMatchesSelector!==undefined)return r.mozMatchesSelector(n);throw new Error("Browser lacks native selectors")},ge=(de().browser.isIE(),function(e,n,r){for(var t=e.dom(),o=I(r)?r:v(!1);t.parentNode;){t=t.parentNode;var i=y.fromDom(t);if(n(i))return S.some(i);if(o(i))break}return S.none()}),he=function(e,n,r){return ge(e,function(e){return me(e,n)},r)},ve={getToolbarItemsOr:(U=_,function(e,n,r){return function(e,n){if(!n(e))throw new Error("Default value doesn't match requested type.")}(r,U),function(e,n){if(A(e)||C(e))throw new Error("expected a string but found: "+e);return M(e)?n:R(e)?!1===e?"":n:e}(e.getParam(n,r),r)})},pe=function(e){return ve.getToolbarItemsOr(e,"quickbars_selection_toolbar","bold italic | quicklink h2 h3 blockquote")},be=function(e){return ve.getToolbarItemsOr(e,"quickbars_insert_toolbar","quickimage quicktable")},Oe=function(a){var e=be(a);0<e.trim().length&&a.ui.registry.addContextToolbar("quickblock",{predicate:function(e){var n,r,t,o=y.fromDom(e),i=a.schema.getTextBlockElements(),u=function(e){return e.dom()===a.getBody()};return(n=o,r="table",t=u,q(me,he,n,r,t)).fold(function(){return(e=o,n=function(e){return e.dom().nodeName.toLowerCase()in i&&a.dom.isEmpty(e.dom())},r=u,q(function(e){return n(e)},ge,e,n,r)).isSome();var e,n,r},function(){return!1})},items:e,position:"line",scope:"editor"})},Ne=function(n){n.ui.registry.addContextToolbar("imageselection",{predicate:function(e){return"IMG"===e.nodeName||"FIGURE"===e.nodeName&&/image/i.test(e.className)},items:"alignleft aligncenter alignright",position:"node"});var e=pe(n);0<e.trim().length&&n.ui.registry.addContextToolbar("textselection",{predicate:function(e){return!n.selection.isCollapsed()},items:e,position:"selection"})};i.add("quickbars",function(e){h(e),Oe(e),Ne(e)}),function we(){}}(window);