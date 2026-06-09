package com.ecommerce.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "store_settings")
public class StoreSettings {

    @Id
    private Long id = 1L; // Hardcoded to 1 because there is only ever ONE settings profile!

    // Global Settings
    private boolean showAnnouncement = true;
    private String announcementText = "Free Insured Shipping Across India | 100% Certified Jewellery";
    private boolean emergencyClose = false;

    // Hero Sliders
    private String slide1Media = "https://cdn.pixabay.com/video/2021/08/25/86259-592868735_large.mp4";
    private String slide1Heading = "The Bridal Masterpiece";
    private String slide1Desc = "Exquisite craftsmanship for your most special day.";

    private String slide2Media = "https://images.unsplash.com/photo-1599643478524-fb66f70d00f7?q=100&w=2800";
    private String slide2Heading = "Diamond Elegance";
    private String slide2Desc = "Discover our latest arrivals in pure diamond settings.";

    // Video Showcase
    private String video1Url = "https://res.cloudinary.com/dq3omqbjo/video/upload/q_auto/f_auto/v1780766925/Cinematic_macro_slow_motion_sh_processed_ch1rhq.mp4";
    private String video1Heading = "Aura Rings";

    private String video2Url = "https://res.cloudinary.com/dq3omqbjo/video/upload/q_auto/f_auto/v1780767017/Close_up_lifestyle_shot_of_a_w_processed_w0zmdu.mp4";
    private String video2Heading = "Royal Necklaces";

    private String video3Url = "https://res.cloudinary.com/dq3omqbjo/video/upload/v1780766841/Macro_shot_of_black_diamonds_a_processed_si6sgq.mp4";
    private String video3Heading = "Bridal Sets";

    // --- GETTERS & SETTERS ---

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public boolean isShowAnnouncement() { return showAnnouncement; }
    public void setShowAnnouncement(boolean showAnnouncement) { this.showAnnouncement = showAnnouncement; }

    public String getAnnouncementText() { return announcementText; }
    public void setAnnouncementText(String announcementText) { this.announcementText = announcementText; }

    public boolean isEmergencyClose() { return emergencyClose; }
    public void setEmergencyClose(boolean emergencyClose) { this.emergencyClose = emergencyClose; }

    public String getSlide1Media() { return slide1Media; }
    public void setSlide1Media(String slide1Media) { this.slide1Media = slide1Media; }

    public String getSlide1Heading() { return slide1Heading; }
    public void setSlide1Heading(String slide1Heading) { this.slide1Heading = slide1Heading; }

    public String getSlide1Desc() { return slide1Desc; }
    public void setSlide1Desc(String slide1Desc) { this.slide1Desc = slide1Desc; }

    public String getSlide2Media() { return slide2Media; }
    public void setSlide2Media(String slide2Media) { this.slide2Media = slide2Media; }

    public String getSlide2Heading() { return slide2Heading; }
    public void setSlide2Heading(String slide2Heading) { this.slide2Heading = slide2Heading; }

    public String getSlide2Desc() { return slide2Desc; }
    public void setSlide2Desc(String slide2Desc) { this.slide2Desc = slide2Desc; }

    public String getVideo1Url() { return video1Url; }
    public void setVideo1Url(String video1Url) { this.video1Url = video1Url; }

    public String getVideo1Heading() { return video1Heading; }
    public void setVideo1Heading(String video1Heading) { this.video1Heading = video1Heading; }

    public String getVideo2Url() { return video2Url; }
    public void setVideo2Url(String video2Url) { this.video2Url = video2Url; }

    public String getVideo2Heading() { return video2Heading; }
    public void setVideo2Heading(String video2Heading) { this.video2Heading = video2Heading; }

    public String getVideo3Url() { return video3Url; }
    public void setVideo3Url(String video3Url) { this.video3Url = video3Url; }

    public String getVideo3Heading() { return video3Heading; }
    public void setVideo3Heading(String video3Heading) { this.video3Heading = video3Heading; }
}