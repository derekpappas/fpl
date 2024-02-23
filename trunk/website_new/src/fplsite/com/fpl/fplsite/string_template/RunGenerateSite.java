
package com.fpl.fplsite.string_template;


import java.text.SimpleDateFormat;
import java.util.Date;
import com.fpl.fplsite.string_template.GenerateSite;

/**
 * @author adam
 *
 */

public class RunGenerateSite {
	public static void main(String[] args) {


		 long totalCount = 0;
		 long totalTime = 0;
		 String country = "united_states";
//		 Page.country = country;
//		 CompanyPage.country = country;
//		 ProductsPage.country = country;
//		 SupportPage.country = country;
//		 NewsPage.country = country;
//		 PartnersPage.country = country;
//		 SolutionsPage.country = country;
//		 BlankPage.country = country;
		 String resultsDir = new SimpleDateFormat("d_MMM_HH:mm:ss").format(new Date());
		 String date = new SimpleDateFormat("HH:mm:ss").format(new Date());
		 long before = System.currentTimeMillis();	
		 GenerateSite genSite = null;
		 date = new SimpleDateFormat("HH:mm:ss").format(new Date());
	 	 System.out.println("date english = " + date);
	 	 
//		 english
	 	 genSite = new GenerateSite();
		 genSite.setCountry(country);
		 genSite.setResultsDir(resultsDir);
		 genSite.generateSite();
		 System.out.println("Generated site:  date = " + date);


		 System.out.println("Done generating pages: see /opt/tmp/ResultsST2 " );
		 System.out.println("Number of generated pages: " + totalCount);
	}
}
