import org.springframework.core.io.FileSystemResource;
import org.springframework.util.FileCopyUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

/** 不使用了!
 *  Created by yu on 2015/4/2.
 *  html等静态文件总是被Spring拦截(默认<mvc:default-servlet-handler default-servlet-name="default" />)
 * ,把这个servlet提前配置web.xml中,让spring不要拦截.
 *  如果不配置nginx就用这个servlet代替,
 *  性能不好.
 *
 */
public class WikiServlet extends HttpServlet {

  public void  service(HttpServletRequest request, HttpServletResponse response){

      try {
          //处理.....
          String  idpath= request.getServletPath();

          String fileString=idpath;   // 前缀处理? 文件系统目录处理!!暂时不处理前缀 // 由于  /wiki/   本身

          File file=new File(fileString);
          if(file.exists()) {
              //如果存在就当是返回文件内容
              FileCopyUtils.copy(new FileSystemResource(fileString).getInputStream(), response.getOutputStream());
          }else {
              //如果没处理就返回到spingMVC
           //   request.getRequestDispatcher("/").forward(request, response);
          }

      } catch (Exception e) {
          e.printStackTrace();
      }

  }

}
