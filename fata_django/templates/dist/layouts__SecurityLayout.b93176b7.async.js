(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([[6],{L9NX:function(t,e,n){"use strict";n.r(e);var a=n("fWQN"),r=n("mtLc"),o=n("yKVA"),i=n("879j"),c=n("q1tI"),s=n.n(c),u=n("tbuW"),l=n("WHYC"),d=n("9kvl"),p=n("s4NR"),h=function(t){Object(o["a"])(n,t);var e=Object(i["a"])(n);function n(){var t;Object(a["a"])(this,n);for(var r=arguments.length,o=new Array(r),i=0;i<r;i++)o[i]=arguments[i];return t=e.call.apply(e,[this].concat(o)),t.state={isReady:!1},t}return Object(r["a"])(n,[{key:"componentDidMount",value:function(){this.setState({isReady:!0});var t=this.props.dispatch;t&&t({type:"user/fetchCurrent"})}},{key:"render",value:function(){var t=this.state.isReady,e=this.props,n=e.children,a=e.loading,r=sessionStorage.getItem("token"),o=Object(p["stringify"])({redirect:window.location.href});return!r&&a||!t?s.a.createElement(u["a"],null):r||"/user/login"===window.location.pathname?n:s.a.createElement(l["c"],{to:"/user/login?".concat(o)})}}]),n}(s.a.Component);e["default"]=Object(d["a"])((function(t){t.user;var e=t.loading;return{loading:e.models.user}}))(h)}}]);