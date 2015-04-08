package my.cutwiki.Filter;

import org.springframework.core.io.FileSystemResource;
import org.springframework.util.FileCopyUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

/**
 * Created by yu on 2015/4/1.
 * 由于wiki的特殊路径使用servlet的拦截器来把D:/abc/index.html这类文件加入进来
 * 目前不使用SpringMVC的拦截器.
 */
public class wikiFilter implements Filter {


    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
        //  127.0.0.1:8080/pro/wiki/我的主页/我的子页�?/我的页面.html?Edit?abcsfsldfsk
        //处理.....
        String  idpath=( (HttpServletRequest)request).getServletPath();

        String fileString=idpath;   // 前缀处理? 文件系统目录处理!!暂时不处理前�? // 由于  /wiki/   本身

        File file=new File(fileString);
        if(fileString.startsWith("/wiki/")) {
            //如果存在就当是返回文件内�?
            if(file.exists()){
                FileCopyUtils.copy(new FileSystemResource(fileString).getInputStream(), response.getOutputStream());
            }else{
                System.out.println("没有这个文件.....");
                response.getWriter().write("{\"state\":\"false\",\"msg\": \"没有找到文件,也许没有这个wiki页面\"}");
            }
        }else {
            //如果没处理就返回到spingMVC
               request.getRequestDispatcher(idpath).forward(request, response);
        }
    }

    public void destroy() {

    }


}
