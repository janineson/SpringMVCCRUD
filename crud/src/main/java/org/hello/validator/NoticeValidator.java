package org.hello.validator;

import java.util.HashMap;
import java.util.Map;

import org.hello.domain.NoticeVO;
import org.springframework.stereotype.Service;

@Service
public class NoticeValidator {
	public Map<String, String> validate(NoticeVO notice) {
		
		Map<String, String> errors = new HashMap<String, String>();
		
		//Declare and check all mandatory fields
		final String[] fields 		= {"author", "contents", "title"};
		final String[] fieldsText 	= {"작성자", "내용", "제목"};
		
		for(int i = 0; i<fields.length; i++){
			//required fields
			 String field = null;
			if (fields[i] == "author") {
				field =  notice.getAuthor();
				notice.setAuthor(escape(field));
			}
			if (fields[i] == "contents") {
				field =  notice.getContents();
				notice.setContents(escape(field));
			}
			if (fields[i] == "title") {
				field =  notice.getTitle();
				notice.setTitle(escape(field));
			}
			
			if(field  == null || field.length() == 0){
				errors.put(fields[i] , fieldsText[i]  + " 입력하십시오.");
			}else {
				if(((fields[i] == "author" || fields[i] =="title") && field.length() > 30) || 
						(fields[i] == "contents" && field.length() > 500)){
					errors.put(fields[i] , fieldsText[i]  + " exceeded max length.");
				}
			}
		}
		
		return errors;
		
	}
	
	//escape special chars when saving in db
	public String escape(String str) {

	   	 if ((str==null) || (str==""))
	   	       return "";
	   	 else
	   	   str = str.toString();

	   	 str = str.replace("&", "&amp;");
		 str = str.replace("<", "&lt;");
		 str = str.replace(">", "&gt;");
		 str = str.replace("\"", "&quot;");
		 str = str.replace("'", "&#039;");
		 
	   	 return str;
	   	 
	   	}
}
