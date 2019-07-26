package com.yida.admin.utils;



import net.sf.json.JSONObject;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class getCodeController {

    static HttpRequestUtil  httpRequestUtil = new HttpRequestUtil();

    //---------微信登录 demo --------
    public static final String APPID ="wxf961b99320b3f5c0";//小程序id
    public static final String SECRET ="a30432454b2f460fb597e560ad19387f";//小程序 appSecret
    public static final  String GRANT_TYPE = "authorization_code";//默认

    /**
     * 获取code
     * @param code 接收小程序发送过来的code
     * @return openid
     */
    public static String getCode(String code){
        String url ="https://api.weixin.qq.com/sns/jscode2session?" +
                "appid=" +APPID+
                "&secret=" +SECRET +
                "&js_code=" +code +
                "&grant_type=" + GRANT_TYPE;
        JSONObject jsonObject = HttpRequestUtil.httpRequest(url, "GET", null);
        //JSONObject jsonObject = httpRequestUtil.httpRequest(url,"GET",null);
        //System.out.println(jsonObject.toString());
        String openid =jsonObject.getString("openid");
        System.out.println("openid : "+openid);
        return openid;
    }

    /**
     * POST请求
     * openid 转 userid
     * @param token 企业微信token
     * @param openid 参数
     * @return userid
     */
    public static String openidShiftUserId(String token,String openid){
        String url ="https://qyapi.weixin.qq.com/cgi-bin/user/convert_to_userid?" +
                "access_token=" +token;
        JSONObject jsonStr = new JSONObject();
        jsonStr.put("openid", openid);
        JSONObject jsonObject = httpRequestUtil.httpRequest(url,"POST",jsonStr.toString());
        System.out.println(jsonObject.toString());
        String userid =jsonObject.getString("userid");
        System.out.println("userId : "+userid);
        return userid;
    }





    //已存在方法，测试使用-----------------------分割线----------------------------------
    public static final String corpid ="wx919fbd2c998bb536";//企业微信id 维达测试
    public static final String corpsecret ="rFRIEHgmNcZpp5mdm2xYB_w5DRirM8Yl2wyXCVDvY_k";//应用id 维达测试
    /**
     *
     * 获取企业微信token
     * @return
     */
    public static String getAccessToken(){
        String url ="https://qyapi.weixin.qq.com/cgi-bin/gettoken?" +
                "corpid=" +corpid+
                "&corpsecret=" +corpsecret;
        JSONObject jsonObject = httpRequestUtil.httpRequest(url,"GET",null);
        String token =jsonObject.getString("access_token");
        System.out.println("企业微信access_token : "+token);
        return token;
    }



    public static void main(String[] args) {
        String code = "033njQBi10winu0xfWzi1TuIBi1njQB3";
       // String token = getAccessToken();
        String token ="9RHlJpVDgDE_F46b9iBmgJcIEGrU8tNVzNC2-rkCkyYmsOzcv9YGXmNbziSuBk-6Kv9tsNMo6QY7gnCpQzNoi7AjjxV1ScVuL-Bpw9ddAjBZ-S4dHqJ5Wv_5bVSYqIN_azaeSDSlP_vJEuHgn7MSiF9an5QFcSHHnKHFOdURVB04SkA_q4dMh-TcMn6t5503CacZwa3vDo1wvj7s2HBjOg";
        String openid = getCode(code);
        openidShiftUserId(token,openid);
    }
}
