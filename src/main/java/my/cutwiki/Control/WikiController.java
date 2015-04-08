package my.cutwiki.Control;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

/**
 * Created by yu on 2015/4/1.
 * wiki平台暂时做在这里.
 * 以wiki为根,
 * 以后可以不要这个根.
 */


@Controller
@RequestMapping(value = "/wiki", produces = { "application/json;charset=UTF-8"})
public class WikiController {

    // idpath以点号做分开.
    // 把wiki加上模板...
    // 把wiki加上编辑/删除等....一系列脚本.
    @RequestMapping("{idpath}")
    public ModelAndView handleRequest(@PathVariable String idpath,//有bug,这种取法可能导致出错......最后一个点后不出来.
                                   //   @PathVariable String type,
                                      HttpServletRequest request,
                                      HttpServletResponse response ) {
        try {
          String contextPath= request.getContextPath();//获取项目路径.
          //  String idpath=(String) request .getAttribute("javax.servlet.include.request_uri");
          //   request.getPathInfo();

            idpath= request.getServletPath();// 重新获取idpath,
          //  idpath = idpath + "." + type;
            //String fileString = "/wiki/" + idpath.replace(".", "/") + ".html";
            String fileString =idpath.replace(".", "/") + ".html";
            String dirString = idpath.replace(".", "/");
            String pp= request.getSession().getServletContext().getRealPath("test.test");
            System.out.println(pp);
            // if (type.endsWith("html")) { // 由于 拦截器优先的方式, html....等图片已经静态化了....
            //由于拦截器和Spring注入方式都是一样的处理方式......所以自己来处理也一样.
            //设置路径为系统/wiki/

//            File file=new File(fileString);
//            if(file.exists()){
//                FileCopyUtils.copy(new FileSystemResource(fileString).getInputStream(), response.getOutputStream());
//                return null;
//            }

         //   }
            String[] filepdir = idpath.split("\\.");
            ModelAndView mv = new ModelAndView("wikiframe");// 加载模板test.ftl,路径从配置文件中取
            mv.addObject("page", contextPath+fileString);//设置属性
            mv.addObject("path", idpath);//设置wiki的主path,
            mv.addObject("content", " Hello world ， test my first spring mvc ! ");//设置属性
            //  mv.getModel().;
            System.out.println("sfsfasdfaslfa;sdflas;dfasldfj调用 了Freemarker");

            for (int i = 0; i < filepdir.length; i++) {
                System.out.println(filepdir[i]);
            }
            //mv.toString();
            return mv;//返回了整个model
        }catch(Exception e){
            e.printStackTrace();
        }
        return  null;
    }
   // @RequestMapping("*.html")
    public String html2() {
        return "测试字符串";
        /*
            ModelAndView mv = new ModelAndView("wikiframe");// 加载模板test.ftl,路径从配置文件中取
            mv.addObject("page", fileString);//设置属性
            mv.addObject("content", " Hello world ， test my first spring mvc ! ");//设置属性
            //  mv.getModel().;
            System.out.println("sfsfasdfaslfa;sdflas;dfasldfj调用 了Freemarker");
         */

    }
    @RequestMapping(value ="/wikiSave", produces = { "application/json;charset=UTF-8"})
    public String saves(String wikipath,String wikiContent,      HttpServletRequest request, HttpServletResponse response) {
          /*
            wikipath必须按  我的主页.我的子页面   这样传值
            wikiContent必须为纯文本
            暂时不压缩.
         */
        String contextPath= request.getContextPath();//获取项目路径.
        String idpath= wikipath;
        String fileString =idpath.replace(".", "/") + ".html";
        String dirString = idpath.replace(".", "/");



        try {

        File dir=new File(dirString);
        if(!dir.exists())
            dir.mkdirs();

        File file=new File(fileString);

        if(!file.exists())
            file.createNewFile();
        BufferedWriter writer = new BufferedWriter(new FileWriter(file));
        writer.write(wikiContent);
        writer.flush();
        writer.close();
            response.getWriter().write( "{\"state\": true, \"msg\":\"保存成功\"}");
           // response.getWriter().write("{\"state\": false, \"msg\":\"保存失败\"}");
        } catch (IOException e) {
            e.printStackTrace();

         //   throw new LogicException("state","文件打开失败,都保存失败,e:"+e.getMessage());

        }


        return "{\"state\": true, \"msg\":\"保存成功\"}";

    }
    @RequestMapping("/wikiUpload")
    public String upload2(			@RequestParam String path,
                                      @RequestParam String fileName,
                                      @RequestParam MultipartFile fileBody) {
        /*
            路径必须按  我的主页/我的子页面  这样传值
            fileName    不能带点多余的点号!
            doc文件会自动转换格式为html
            zip文件
            图片
         */
        return "测试字符串";

    }

    //新建文件夹.....
    public void pro(){


    }

}

