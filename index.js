var x$;x$=angular.module("main",[]),x$.controller("main",["$scope","$http","$interval"].concat(function(n,t,e){var o;return n.posts=[],n.pending=[],n.feeding=function(){return n.handler=e(function(){var t,e,r,a;return n.pending.length?(t=parseInt(Math.random()*n.pending.length),e=n.pending.splice(t,1)[0],r=e[0],a=e[1],o(r,a)):void 0},1e3)},n.token=null,n.fetch=function(){var e,o;return e="https://graph.facebook.com/v2.4/search",o={q:"一句話惹怒",type:"event",access_token:n.token,format:"json",method:"GET",pretty:0,limit:100},t({url:e,params:o,method:"GET"}).success(function(t){return n.list=t.data,n.pending=n.list.map(function(n){return[n.id,n.name]}),n.feeding()})},o=function(o,r){var a,c;return a="https://graph.facebook.com/v2.4/"+o+"/feed",c={access_token:n.token,limit:5},t({url:a,params:c,method:"GET"}).success(function(t){return t.data.map(function(n){return n.board=r,n.timestamp=new Date(n.updated_time).getTime()}),n.posts=n.posts.concat(t.data)}).error(function(){return e.cancel(n.handler)})},n.getat=function(){return FB.getLoginStatus(function(t){return"connected"===t.status?n.$apply(function(){return n.token=t.authResponse.accessToken}):void 0})},n.login=function(){return n.token?void 0:FB.login(function(t){return"connected"===t.status?n.$apply(function(){return n.token=t.authResponse.accessToken}):void 0})}}));