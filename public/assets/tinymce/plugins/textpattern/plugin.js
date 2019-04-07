/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.0.3 (2019-03-19)
 */
!function(f){"use strict";var t,n,e,r,o,a=function(t){var n=t,e=function(){return n};return{get:e,set:function(t){n=t},clone:function(){return a(e())}}},i=tinymce.util.Tools.resolve("tinymce.PluginManager"),u=function(){for(var t=[],n=0;n<arguments.length;n++)t[n]=arguments[n]},s=function(t){return function(){return t}},c=function(t){return t},l=s(!1),d=s(!0),m=l,g=d,h=function(){return p},p=(r={fold:function(t,n){return t()},is:m,isSome:m,isNone:g,getOr:e=function(t){return t},getOrThunk:n=function(t){return t()},getOrDie:function(t){throw new Error(t||"error: getOrDie called on none.")},getOrNull:function(){return null},getOrUndefined:function(){return undefined},or:e,orThunk:n,map:h,ap:h,each:function(){},bind:h,flatten:h,exists:m,forall:g,filter:h,equals:t=function(t){return t.isNone()},equals_:t,toArray:function(){return[]},toString:s("none()")},Object.freeze&&Object.freeze(r),r),v=function(e){var t=function(){return e},n=function(){return o},r=function(t){return t(e)},o={fold:function(t,n){return n(e)},is:function(t){return e===t},isSome:g,isNone:m,getOr:t,getOrThunk:t,getOrDie:t,getOrNull:t,getOrUndefined:t,or:n,orThunk:n,map:function(t){return v(t(e))},ap:function(t){return t.fold(h,function(t){return v(t(e))})},each:function(t){t(e)},bind:r,flatten:t,exists:r,forall:r,filter:function(t){return t(e)?o:p},equals:function(t){return t.is(e)},equals_:function(t,n){return t.fold(m,function(t){return n(e,t)})},toArray:function(){return[e]},toString:function(){return"some("+e+")"}};return o},w={some:v,none:h,from:function(t){return null===t||t===undefined?p:v(t)}},y=function(n){return function(t){return function(t){if(null===t)return"null";var n=typeof t;return"object"===n&&Array.prototype.isPrototypeOf(t)?"array":"object"===n&&String.prototype.isPrototypeOf(t)?"string":n}(t)===n}},O=y("string"),N=y("object"),E=y("array"),b=y("function"),k=(o=Array.prototype.indexOf)===undefined?function(t,n){return x(t,n)}:function(t,n){return o.call(t,n)},T=function(t,n){for(var e=t.length,r=new Array(e),o=0;o<e;o++){var a=t[o];r[o]=n(a,o,t)}return r},D=function(t,n){for(var e=0,r=t.length;e<r;e++)n(t[e],e,t)},C=function(t,n){for(var e=[],r=0,o=t.length;r<o;r++){var a=t[r];n(a,r,t)&&e.push(a)}return e},x=function(t,n){for(var e=0,r=t.length;e<r;++e)if(t[e]===n)return e;return-1},_=function(t,n){for(var e=0,r=t.length;e<r;++e)if(!0!==n(t[e],e,t))return!1;return!0},P=Array.prototype.slice,R=(b(Array.from)&&Array.from,Object.keys),I=Object.hasOwnProperty,A=function(t,n){return I.call(t,n)},S=(function(i){if(!E(i))throw new Error("cases must be an array");if(0===i.length)throw new Error("there must be at least one case");var u=[],e={};D(i,function(t,r){var n=R(t);if(1!==n.length)throw new Error("one and only one name per case");var o=n[0],a=t[o];if(e[o]!==undefined)throw new Error("duplicate key detected:"+o);if("cata"===o)throw new Error("cannot have a case named cata (sorry)");if(!E(a))throw new Error("case arguments must be an array");u.push(o),e[o]=function(){var t=arguments.length;if(t!==a.length)throw new Error("Wrong number of arguments to case "+o+". Expected "+a.length+" ("+a+"), got "+t);for(var e=new Array(t),n=0;n<e.length;n++)e[n]=arguments[n];return{fold:function(){if(arguments.length!==i.length)throw new Error("Wrong number of arguments to fold. Expected "+i.length+", got "+arguments.length);return arguments[r].apply(null,e)},match:function(t){var n=R(t);if(u.length!==n.length)throw new Error("Wrong number of arguments to match. Expected: "+u.join(",")+"\nActual: "+n.join(","));if(!_(u,function(t){return-1<k(n,t)}))throw new Error("Not all branches were specified when using match. Specified: "+n.join(", ")+"\nRequired: "+u.join(", "));return t[o].apply(null,e)},log:function(t){f.console.log(t,{constructors:u,constructor:o,params:e})}}}})}([{bothErrors:["error1","error2"]},{firstError:["error1","value2"]},{secondError:["value1","error2"]},{bothValues:["value1","value2"]}]),function(t){var n=[],e=[];return D(t,function(t){t.fold(function(t){n.push(t)},function(t){e.push(t)})}),{errors:n,values:e}}),B=function(e){return{is:function(t){return e===t},isValue:d,isError:l,getOr:s(e),getOrThunk:s(e),getOrDie:s(e),or:function(t){return B(e)},orThunk:function(t){return B(e)},fold:function(t,n){return n(e)},map:function(t){return B(t(e))},mapError:function(t){return B(e)},each:function(t){t(e)},bind:function(t){return t(e)},exists:function(t){return t(e)},forall:function(t){return t(e)},toOption:function(){return w.some(e)}}},M=function(e){return{is:l,isValue:l,isError:d,getOr:c,getOrThunk:function(t){return t()},getOrDie:function(){return t=String(e),function(){throw new Error(t)}();var t},or:function(t){return t},orThunk:function(t){return t()},fold:function(t,n){return t(e)},map:function(t){return M(e)},mapError:function(t){return M(t(e))},each:u,bind:function(t){return M(e)},exists:l,forall:d,toOption:w.none}},j={value:B,error:M},U=function(t){return"inline-command"===t.type||"inline-format"===t.type},L=function(t){return"block-command"===t.type||"block-format"===t.type},q=function(t){return n=t,e=function(t,n){return t.start.length===n.start.length?0:t.start.length>n.start.length?-1:1},(r=P.call(n,0)).sort(e),r;var n,e,r},F=function(o){var a=function(t){return j.error({message:t,pattern:o})},t=function(t,n,e){if(o.format===undefined)return o.cmd!==undefined?O(o.cmd)?j.value(e(o.cmd,o.value)):a(t+" pattern has non-string `cmd` parameter"):a(t+" pattern is missing both `format` and `cmd` parameters");var r=void 0;if(E(o.format)){if(!_(o.format,O))return a(t+" pattern has non-string items in the `format` array");r=o.format}else{if(!O(o.format))return a(t+" pattern has non-string `format` parameter");r=[o.format]}return j.value(n(r))};if(!N(o))return a("Raw pattern is not an object");if(!O(o.start))return a("Raw pattern is missing `start` parameter");if(o.end===undefined)return o.replacement!==undefined?O(o.replacement)?0===o.start.length?a("Replacement pattern has empty `start` parameter"):j.value({type:"inline-command",start:"",end:o.start,cmd:"mceInsertContent",value:o.replacement}):a("Replacement pattern has non-string `replacement` parameter"):0===o.start.length?a("Block pattern has empty `start` parameter"):t("Block",function(t){return{type:"block-format",start:o.start,format:t[0]}},function(t,n){return{type:"block-command",start:o.start,cmd:t,value:n}});if(!O(o.end))return a("Inline pattern has non-string `end` parameter");if(0===o.start.length&&0===o.end.length)return a("Inline pattern has empty `start` and `end` parameters");var e=o.start,r=o.end;return 0===r.length&&(r=e,e=""),t("Inline",function(t){return{type:"inline-format",start:e,end:r,format:t}},function(t,n){return{type:"inline-command",start:e,end:r,cmd:t,value:n}})},V=function(t){return"block-command"===t.type?{start:t.start,cmd:t.cmd,value:t.value}:"block-format"===t.type?{start:t.start,format:t.format}:"inline-command"===t.type?"mceInsertContent"===t.cmd&&""===t.start?{start:t.end,replacement:t.value}:{start:t.start,end:t.end,cmd:t.cmd,value:t.value}:"inline-format"===t.type?{start:t.start,end:t.end,format:1===t.format.length?t.format[0]:t.format}:void 0},W=function(t){return{inlinePatterns:C(t,U),blockPatterns:q(C(t,L))}},Y=function(r){return{setPatterns:function(t){var n=S(T(t,F));if(0<n.errors.length){var e=n.errors[0];throw new Error(e.message+":\n"+JSON.stringify(e.pattern,null,2))}r.set(W(n.values))},getPatterns:function(){return T(r.get().inlinePatterns,V).concat(T(r.get().blockPatterns,V))}}},z="undefined"!=typeof f.window?f.window:Function("return this;")(),G=function(){for(var t=[],n=0;n<arguments.length;n++)t[n]=arguments[n];var e=z.console;e&&(e.error?e.error.apply(e,t):e.log.apply(e,t))},J=[{start:"*",end:"*",format:"italic"},{start:"**",end:"**",format:"bold"},{start:"#",format:"h1"},{start:"##",format:"h2"},{start:"###",format:"h3"},{start:"####",format:"h4"},{start:"#####",format:"h5"},{start:"######",format:"h6"},{start:"1. ",cmd:"InsertOrderedList"},{start:"* ",cmd:"InsertUnorderedList"},{start:"- ",cmd:"InsertUnorderedList"}],K=function(t){var n,e,r=(n=t,e="textpattern_patterns",A(n,e)?w.from(n[e]):w.none()).getOr(J);if(!E(r))return G("The setting textpattern_patterns should be an array"),{inlinePatterns:[],blockPatterns:[]};var o=S(T(r,F));return D(o.errors,function(t){return G(t.message,t.pattern)}),W(o.values)},X=tinymce.util.Tools.resolve("tinymce.util.Delay"),H=tinymce.util.Tools.resolve("tinymce.util.VK"),Q=function(t,n,e){return""===n||!(t.length<n.length)&&t.substr(e,e+n.length)===n},Z=tinymce.util.Tools.resolve("tinymce.dom.TreeWalker"),$=tinymce.util.Tools.resolve("tinymce.util.Tools"),tt=(f.Node.ATTRIBUTE_NODE,f.Node.CDATA_SECTION_NODE,f.Node.COMMENT_NODE,f.Node.DOCUMENT_NODE,f.Node.DOCUMENT_TYPE_NODE,f.Node.DOCUMENT_FRAGMENT_NODE,f.Node.ELEMENT_NODE),nt=f.Node.TEXT_NODE,et=(f.Node.PROCESSING_INSTRUCTION_NODE,f.Node.ENTITY_REFERENCE_NODE,f.Node.ENTITY_NODE,f.Node.NOTATION_NODE,function(t){return t.nodeType===tt}),rt=function(t){return t.nodeType===nt},ot=function(t,n,e){if(e<0||e>n.data.length)return w.none();for(var r=[e],o=n;o!==t&&o.parentNode;){for(var a=o.parentNode,i=0;i<a.childNodes.length;i++)if(a.childNodes[i]===o){r.push(i);break}o=a}return o===t?w.some(r.reverse()):w.none()},at=function(t,n,e,r,o){return ot(t,n,e).bind(function(n){return ot(t,r,o).map(function(t){return{start:n,end:t}})})},it=function(t,n){var e,r,o,a=n.slice(),i=a.pop();return(e=a,r=function(t,n){return t.bind(function(t){return w.from(t.childNodes[n])})},o=w.some(t),D(e,function(t){o=r(o,t)}),o).bind(function(t){return rt(t)&&0<=i&&i<=t.data.length?w.some({node:t,offset:i}):w.none()})},ut=function(t,n,e){if(rt(t)&&0<n)return w.some({node:t,offset:n});var r;if(0<n)r=t.childNodes[n-1];else for(var o=t;o&&o!==e&&!r;o=o.parentNode)r=o.previousSibling;var a=new Z(r,e);for(o=a.current();o;o=a.prev())if(rt(o)&&0<o.length)return w.some({node:o,offset:o.length});return w.none()},ft=function(a,i,t,n,u,f){return void 0===f&&(f=!1),0!==i.start.length||f?ut(t,n,u).filter(function(t){return a.getParent(t.node,a.isBlock)===u}).bind(function(t){var n=t.node,e=t.offset,r=n.data.substring(0,e),o=r.lastIndexOf(i.start);return-1===o?-1!==r.indexOf(i.end)?w.none():ft(a,i,n,0,u,f&&0===r.length):-1!==r.indexOf(i.end,o+i.start.length)?w.none():f&&o+i.start.length===r.length?w.none():w.some({node:n,offset:o})}):w.some({node:t,offset:n})},st=function(c,l,t,n,d){return ut(t,n,d).bind(function(t){for(var u=t.node,f=t.offset,s=u.data.substring(0,f),n=function(n){var t,e,a=l[n];if(t=s,e=a.end,!Q(t,e,t.length-e.length))return"continue";var r=f-a.end.length,o=0<a.start.length&&0<a.end.length,i=(o?w.some(!0):w.none()).bind(function(){var t=l.slice();return t.splice(n,1),st(c,t,u,r,d)}).fold(function(){return ft(c,a,u,r,d,o).map(function(t){var n=t.node,e=t.offset,r=at(c.getRoot(),n,e,u,f).getOrDie("Internal constraint violation");return[{pattern:a,range:r}]})},function(o){var n,e,t=(n=c.getRoot(),e=o[o.length-1].range,it(n,e.start).bind(function(t){var r=t.node,o=t.offset;return it(n,e.end).map(function(t){var n=t.node,e=t.offset;return{startNode:r,startOffset:o,endNode:n,endOffset:e}})})).getOrDie("Internal constraint violation");return ft(c,a,t.startNode,t.startOffset,d).map(function(t){var n=t.node,e=t.offset,r=at(c.getRoot(),n,e,u,f).getOrDie("Internal constraint violation");return o.concat([{pattern:a,range:r}])})});return i.isSome()?{value:i}:void 0},e=0;e<l.length;e++){var r=n(e);if("object"==typeof r)return r.value}return w.none()})},ct=function(t,n,e,r){if(!1===e.collapsed)return[];var o=t.getParent(e.startContainer,t.isBlock);return st(t,n,e.startContainer,e.startOffset-(r?1:0),o).getOr([])},lt=0;function dt(){for(var t=[],n=0;n<arguments.length;n++)t[n]=arguments[n];var e=t.pop();return function(t,n){for(var e=[],r=0;r<t.length;r++){var o=t[r];if(!o.isSome())return w.none();e.push(o.getOrDie())}return w.some(n.apply(null,e))}(t,e)}var mt=function(e,r){for(var t,n,o=e.dom,a=function(t){return o.create("span",{"data-mce-type":"bookmark",id:t})},i=function(t){return dt(w.from(o.select("#"+t.start)[0]),w.from(o.select("#"+t.end)[0]),function(t,n){var e=o.createRng();return e.setStartAfter(t),function(t,n,e){for(var r=new Z(t,e);r.next();){var o=r.current();if(!rt(o)||0!==o.data.length)return o===n}return!1}(t,n,o.getRoot())?e.collapse(!0):e.setEndBefore(n),e})},u=(t="mce_",n=(new Date).getTime(),t+"_"+Math.floor(1e9*Math.random())+ ++lt+String(n)),f=T(r,function(t,n){return{start:u+"_"+n+"_start",end:u+"_"+n+"_end"}}),s=e.selection.getBookmark(),c=r.length-1;0<=c;c--){var l=r[c],d=l.pattern,m=l.range,g=it(o.getRoot(),m.end).getOrDie("Failed to resolve range["+c+"].end"),h=g.node,p=g.offset,v=0===p?h:h.splitText(p);v.parentNode.insertBefore(a(f[c].end),v),0<d.start.length&&h.deleteData(p-d.end.length,d.end.length)}for(c=0;c<r.length;c++){var y=r[c],O=(d=y.pattern,m=y.range,it(o.getRoot(),m.start).getOrDie("Failed to resolve range.start")),N=O.node,E=O.offset,b=0===E?N:N.splitText(E);b.parentNode.insertBefore(a(f[c].start),b),0<d.start.length?b.deleteData(0,d.start.length):b.deleteData(0,d.end.length)}var k=function(t){var n=r[t].pattern;i(f[t]).each(function(t){e.selection.setRng(t),"inline-format"===n.type?n.format.forEach(function(t){e.formatter.apply(t)}):e.execCommand(n.cmd,!1,n.value)}),o.remove(f[t].start),o.remove(f[t].end)};for(c=0;c<r.length;c++)k(c);e.selection.moveToBookmark(s)},gt=function(t,n){var e=t.dom,r=t.selection.getRng(),o=e.getParent(r.startContainer,e.isBlock);if(o&&e.is(o,"p")&&et(o)){for(var a,i,u,f,s=new Z(o,o);a=s.next();)if(rt(a)){i=a;break}if(i&&(u=i.data,f=n.start,Q(u,f,0)&&$.trim(o.textContent).length!==n.start.length)){var c=t.selection.getBookmark();if("block-format"===n.type){var l=t.formatter.get(n.format);l&&l[0].block&&t.undoManager.transact(function(){i.deleteData(0,n.start.length),t.selection.select(o),t.formatter.apply(n.format)})}else"block-command"===n.type&&t.undoManager.transact(function(){i.deleteData(0,n.start.length),t.selection.select(o),t.execCommand(n.cmd,!1,n.value)});t.selection.moveToBookmark(c)}}},ht=function(t,n,e){for(var r=0;r<t.length;r++)if(e(t[r],n))return!0},pt=function(r,t){var o=ct(r.dom,t.inlinePatterns,r.selection.getRng(),!1),a=function(t,n,e){var r=t.getParent(e.startContainer,t.isBlock);if(!t.is(r,"p")||!et(r))return w.none();for(var o,a,i=new Z(r,r);o=i.next();)if(rt(o)){a=o;break}if(!a)return w.none();var u=function(t,n){for(var e=0;e<t.length;e++){var r=t[e];if(0===n.indexOf(r.start)&&(!r.end||n.lastIndexOf(r.end)===n.length-r.end.length))return r}}(n,a.data);return u?$.trim(r.textContent).length===u.start.length?w.none():w.some(u):w.none()}(r.dom,t.blockPatterns,r.selection.getRng());return!(!r.selection.isCollapsed()||!(0<o.length||a.isSome())||(r.undoManager.add(),r.undoManager.extra(function(){r.execCommand("mceInsertNewLine")},function(){r.insertContent("\ufeff"),mt(r,o),a.each(function(t){return gt(r,t)});var t=r.selection.getRng(),n=r.dom.getParent(t.startContainer,r.dom.isBlock),e=ut(t.startContainer,t.startOffset,n);r.execCommand("mceInsertNewLine"),e.each(function(t){"\ufeff"===t.node.data.charAt(t.offset-1)&&(t.node.deleteData(t.offset-1,1),r.dom.isEmpty(t.node.parentNode)&&r.dom.remove(t.node.parentNode))})}),0))},vt=function(t,n){var e=ct(t.dom,n.inlinePatterns,t.selection.getRng(),!0);0<e.length&&t.undoManager.transact(function(){mt(t,e)})},yt=function(t,n){return ht(t,n,function(t,n){return t.charCodeAt(0)===n.charCode})},Ot=function(t,n){return ht(t,n,function(t,n){return t===n.keyCode&&!1===H.modifierPressed(n)})},Nt=function(n,e){var r=[",",".",";",":","!","?"],o=[32];n.on("keydown",function(t){13!==t.keyCode||H.modifierPressed(t)||pt(n,e.get())&&t.preventDefault()},!0),n.on("keyup",function(t){Ot(o,t)&&vt(n,e.get())}),n.on("keypress",function(t){yt(r,t)&&X.setEditorTimeout(n,function(){vt(n,e.get())})})};i.add("textpattern",function(t){var n=a(K(t.settings));return Nt(t,n),Y(n)}),function Et(){}}(window);