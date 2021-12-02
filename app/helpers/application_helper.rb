module ApplicationHelper
	def devise_mapping
	  Devise.mappings[:admin]
	end

	def resource_name
	  devise_mapping.name
	end

	def resource_class
	  devise_mapping.to
	end

	def tab_item (this_tab,selected_tab,item_link,url,id=nil)
	    output = "<li"
	    if selected_tab==this_tab
	      output << " class=\"active\" "
	    end
	    output << ">"
	    output << "<i class=\"icon-chevron-right\"></i>"
	    if id.nil?
	    	output << "<a href=\"#{url}\" >#{item_link}</a>"
	    else
	    	output << "<a href=\"#{url}\" id=\"#{id}\">#{item_link}</a>"
	    end
	    output << "</li>"
  	end 

	def side_menu_item (this_tab,selected_tab,item_link,url,icon_class,is_parent_menu=false)
	    output = "<li"
	    if selected_tab==this_tab
	    	if is_parent_menu==true
	      		output << " class=\"active open\" "
	      	else
	      		output << " class=\"active\" "
	      	end
	    end
	    output << ">"
	    if is_parent_menu==true
	    	output << "<a class=\"dropdown-toggle\" href=\"#\" >"
	    else
	    	output << "<a href=\"#{url}\" >"
	    end
	   	output << "<i class=\"#{icon_class}\"></i>"
	    output << "<span class=\"menu-text\">"
	    output << "#{item_link}</span>"
	    if is_parent_menu==true
	    	output << "<b class=\"arrow icon-angle-down\"></b></a>"
	    else
	    	output << "</a></li>"
		end
  	end

	def side_sub_menu_item (this_tab,selected_tab,item_link,url,is_last=false)
	    output = "<li"
	    if selected_tab==this_tab
	      output << " class=\"active\" "
	    end
	    output << ">"
	   	output << "<a href=\"#{url}\" >"
	   	output << "<i class=\"icon-double-angle-right\"></i>"
	   	output << "#{item_link}</a>"
	    output << "</li>"
	    if is_last==true
	    	output << "</ul></li>"
	    end
	    output
  	end 


  	def menu_item (this_menu,selected_menu,item_link,url,id=nil)
	    output = "<li"
	    if selected_menu==this_menu
	      output << " class=\"active\" "
	    end
	    output << ">"
	    if id.nil?
	    	output << "<a href=\"#{url}\" >#{item_link}</a>"
	    else
	    	output << "<a href=\"#{url}\" id=\"#{id}\">#{item_link}</a>"
	    end
	    output << "</li>"
  	end

  	def year_generation(year="2013")
  		ini_date="#{year}/01/01".to_date
  		(1..53).each do |week|
  			ini=ini_date.at_beginning_of_week
  			out=ini+4.days
  			puts "Week #{week} :: desde #{ini} hasta #{out}"
  			ini_date=out+3.days
  		end
  	end


  	def is_this_week_of_this_month_sumary(date=Time.now.to_date)
  	
	  	puts ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: \n Este mes [#{date.month}] tiene #{date.total_weeks} semanas"
	  	cont=0
	  	week_of_month=0
	  	date.week_split.each do | w |
	  	    cont+=1
	  	  	nils=0
			w.each do |wd|
				nils+=1 if wd.nil?
		    end
			
			week_size=w.count

			
			is_of_this_mount=true

		    total_days=week_size-nils

			unless total_days > 3
				is_of_this_mount=false
			end
		    strin=""
		    strin += " #{cont} :: La semana del #{w.compact.first} al #{w.last} tiene #{total_days} dia(s)"
		    if is_of_this_mount
		    	strin += "y pertenece a este mes "
		    	week_of_month+=1
		    else
		    	strin += "y no pertenece a este mes"
		    end
		    puts strin
		end
		puts ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: \n Este mes tiene #{week_of_month} semanas laborales"
	end

  	def is_this_week_of_this_month(date=Time.now.to_date)
  	
	  	puts ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: \n Este mes [#{date.month}] tiene #{date.total_weeks} semanas"
	  	cont=0
	  	week_of_month=0
	  	date.week_split.each do | w |
	  	    cont+=1
	  	  	nils=0
			w.each do |wd|
				nils+=1 if wd.nil?
		    end
			
			week_size=w.count

			
			is_of_this_mount=true

		    total_days=week_size-nils

			unless total_days > 3
				is_of_this_mount=false
			end
		    strin=""
		    strin += " #{cont} :: La semana del #{w.compact.first} al #{w.last} tiene #{total_days} dia(s)"
		    if is_of_this_mount
		    	strin += "y pertenece a este mes "
		    	week_of_month+=1
		    else
		    	strin += "y no pertenece a este mes"
		    end
		    puts strin
		end
		puts ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: \n Este mes tiene #{week_of_month} semanas laborales"
	end


end