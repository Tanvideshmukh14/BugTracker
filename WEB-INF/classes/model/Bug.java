package model;

public class Bug {
    private int id;
    private String title;
    private String description;
    private String severity;

    public Bug() {}

    public Bug(int id, String title, String description, String severity) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.severity = severity;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getSeverity() { return severity; }
    public void setSeverity(String severity) { this.severity = severity; }
}
