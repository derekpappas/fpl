package com.fpl.fplsite.string_template;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.ArrayList;

import org.antlr.stringtemplate.StringTemplate;
import org.antlr.stringtemplate.StringTemplateGroup;

/**
 * @author adam
 *
 */

public class GenerateSite {
	/** My template library */
	static ClassLoader cl = Thread.currentThread().getContextClassLoader();
	static public StringTemplateGroup templates = new StringTemplateGroup("mygroup", System.getenv("TEMPLATE_DIR"));
	/** StringTemplateErrorListener for the group*/
	 
	private String path = "/opt/tmp/ResultsST2_";

	public static String country = null;
	private String resultsDir = null;
	private String pageName = null;
	
	/** object used for internationalization purposes*/
	private Properties strings = null;

	private List<String> pageNameList =  new ArrayList<String>() ;
 
	public GenerateSite() {

		pageNameList.add("about");
		pageNameList.add("advisory_board");
		//		pageNameList.add("application_specific_processors");
		pageNameList.add("articles");
		//		pageNameList.add("asm_gen");
//		pageNameList.add("c++_functional_simulator");
//		pageNameList.add("c++_generated_code");
		pageNameList.add("careers");
		pageNameList.add("company");
		pageNameList.add("contact");
		pageNameList.add("design_management_system");
		pageNameList.add("directors");
		pageNameList.add("editorial");
		pageNameList.add("index");
		pageNameList.add("industry");
		pageNameList.add("infrastructure_specification");
		pageNameList.add("infrastructure_compiler");
		pageNameList.add("infrastructure_components");
		pageNameList.add("interconnect");
		pageNameList.add("introduction");
		pageNameList.add("ip");
		pageNameList.add("ip");
		pageNameList.add("isa");
		pageNameList.add("management");
		//		pageNameList.add("mbist");
		pageNameList.add("memorymap");
		pageNameList.add("news");
		pageNameList.add("offices");
		pageNameList.add("overview");
		pageNameList.add("papers");
		pageNameList.add("partners");
		//		pageNameList.add("processor_ring");
		pageNameList.add("products");
		pageNameList.add("register_file_generator");
		pageNameList.add("request_for_info");
		pageNameList.add("register_generator");
		//		pageNameList.add("risc_core");
		pageNameList.add("reference_model");
		pageNameList.add("services");
		pageNameList.add("signup");
		pageNameList.add("sitemap");
		pageNameList.add("success_stories");
		pageNameList.add("support");
		pageNameList.add("support_centers");
		pageNameList.add("supported_platforms");
		pageNameList.add("tech_partners");
		pageNameList.add("technology");
		//		pageNameList.add("testability_controller");
		pageNameList.add("testbench");
		pageNameList.add("trade_shows");
		pageNameList.add("universities");
		pageNameList.add("white_papers");

	}

	public void generateSite() {
		for (String pageName : pageNameList) {
			generatePage(pageName);
		}
	}

	public void generatePage(String pageName) {

		// load strings from a properties files like en.strings
		Properties strings = new Properties();
		FileInputStream is = null;
		try {
			is = new FileInputStream(System.getenv("TEMPLATE_DIR") + "/" + country+".strings");
			strings.load(is);
		} catch (IOException e) {
			e.printStackTrace();
		}

		// get the templates from the st files
		StringTemplate headerST = templates.getInstanceOf("header");
		StringTemplate footerST = templates.getInstanceOf("footer");
		StringTemplate pageST   = generatePageST(pageName);
		StringTemplate bodyST   = generateBodyST(pageName);

		// add the templates to the page template
		headerST.setAttribute("pageName", pageName);

		// add the templates to the page template
		pageST.setAttribute("header"    , headerST          );
		pageST.setAttribute(pageName + "_body",       bodyST ); // select the correct body template name INSIDE of the page template
		pageST.setAttribute("strings"   , strings           );
		pageST.setAttribute("title"     , getTitle(pageName));
		pageST.setAttribute("path"      , path              );
		pageST.setAttribute("resultsDir", getResultsDir()   );
		pageST.setAttribute("country"   , getCountry()      );
		pageST.setAttribute("pageName"  , pageName          );
		pageST.setAttribute("footer"    , footerST          );

		String page = pageST.toString(); // convert the page to string
		this.print2File(page, pageName); // render page
	}
	
	public StringTemplate generatePageST(String pageName) {
		String pageTemplateName = pageName + "_page";
		System.out.println ("pageTemplateName = " + pageTemplateName);
    	StringTemplate pageST = templates.getInstanceOf(pageTemplateName);
		return pageST;
    }
	
	public StringTemplate generateBodyST(String pageName) {
		String bodyTemplateName = pageName + "_body";
		System.out.println ("bodyTemplateName = " + bodyTemplateName);
    	StringTemplate bodyST = templates.getInstanceOf(bodyTemplateName);
		return bodyST;
    }
	
	public void setCountry(String country){
		this.country = country;
	}

	public String getCountry(){
		return country;
	}

	public String getResultsDir() {
		return resultsDir;
	}

	public void setResultsDir(String resultsDir) {
		this.resultsDir = resultsDir;
	}


	public void setPageName(String pageName) {
		this.pageName = pageName;
		
	}

	public void print2File(String page, String pageName) {
		File htmlDir = new File("/opt/tmp/ResultsST2_" + resultsDir + "_" + country);
		htmlDir.mkdir();
		File htmlFile = new File("/opt/tmp/" + htmlDir.getName()  + "/" + pageName + ".htm");
		try 
			{
				htmlFile.createNewFile();
				BufferedWriter bw = new BufferedWriter(new FileWriter(htmlFile));
				bw.write(page);
				bw.close();

			} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	public String getTitle(String pageName) {
    	return "FPL - " + pageName; 
    }

}
