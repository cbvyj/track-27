package dto;

public class RecommendDto {
	private String no, title, category, sub_category, tags, region, link, content, attach, secret, state, reg_id, reg_name, reg_date, update_date; 
	private int hit,lat,lng;
	
	
	public RecommendDto(String no, String title, String category, String sub_category, String tags, String region,
			String link, String content, String attach, String secret, String state, String reg_id, String reg_name,
			String reg_date, String update_date, int hit, int lat, int lng) {
		super();
		this.no = no;
		this.title = title;
		this.category = category;
		this.sub_category = sub_category;
		this.tags = tags;
		this.region = region;
		this.link = link;
		this.content = content;
		this.attach = attach;
		this.secret = secret;
		this.state = state;
		this.reg_id = reg_id;
		this.reg_name = reg_name;
		this.reg_date = reg_date;
		this.update_date = update_date;
		this.hit = hit;
		this.lat = lat;
		this.lng = lng;
	}


	
	
	public int getLat() {
		return lat;
	}




	public int getLng() {
		return lng;
	}




	public String getNo() {
		return no;
	}


	public String getTitle() {
		return title;
	}


	public String getCategory() {
		return category;
	}


	public String getSub_category() {
		return sub_category;
	}


	public String getTags() {
		return tags;
	}


	public String getRegion() {
		return region;
	}


	public String getLink() {
		return link;
	}


	public String getContent() {
		return content;
	}


	public String getAttach() {
		return attach;
	}


	public String getSecret() {
		return secret;
	}


	public String getState() {
		return state;
	}


	public String getReg_id() {
		return reg_id;
	}


	public String getReg_name() {
		return reg_name;
	}


	public String getReg_date() {
		return reg_date;
	}


	public String getUpdate_date() {
		return update_date;
	}


	public int getHit() {
		return hit;
	}
	

	
	
}
