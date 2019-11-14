var nativeShare = new NativeShare()
var shareData = {
    title: '分享认购结果',
    desc: '分享认购结果',
    link: 'http://106.12.176.252:8083',
    image: '~/Images/subscription.png',
    success: function () {
        alert('转发成功')
    },
    fail: function () {
        alert('转发失败')
    }
}
nativeShare.setShareData(shareData);
function callShare(command) {
    try {
        nativeShare.call(command)
    } catch (err) {
        alert(err.message)
    }
}
$(function () {
    $('#forwardImg').click(function () {
        callShare('default');
    });
    var browser = {
        versions: function () {
            var u = navigator.userAgent, app = navigator.appVersion;
            return {
                trident: u.indexOf('Trident') > -1, //IE内核
                presto: u.indexOf('Presto') > -1, //opera内核
                webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
                gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,//火狐内核
                mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
                ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                android: u.indexOf('Android') > -1 || u.indexOf('Adr') > -1, //android终端
                iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
                iPad: u.indexOf('iPad') > -1, //是否iPad
                webApp: u.indexOf('Safari') == -1, //是否web应该程序，没有头部与底部
                weixin: u.indexOf('MicroMessenger') > -1, //是否微信 （2015-01-22新增）
                qq: u.match(/\sQQ/i) == " qq" //是否QQ
            };
        }(),
        language: (navigator.browserLanguage || navigator.language).toLowerCase()
    }
    //判断是否IE内核
    // if (browser.versions.trident) { alert("is IE"); }
    //判断是否webKit内核
    //if (browser.versions.webKit) { alert("is webKit"); }
    //判断是否移动端
    //if (browser.versions.mobile || browser.versions.android || browser.versions.ios) { alert("移动端"); }
    //检测浏览器语言

    currentLang = navigator.language;   //判断除IE外其他浏览器使用语言
    if (!currentLang) {//判断IE浏览器使用语言
        currentLang = navigator.browserLanguage;
    }
    //alert(currentLang);
});