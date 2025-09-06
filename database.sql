-- This script enhances the database table with more details and populates it.
-- It is designed to be run once when the server starts.

-- Drop the table if it already exists to ensure a clean setup
DROP TABLE IF EXISTS internships;

-- Create the internships table with new fields for details
CREATE TABLE internships (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    company TEXT NOT NULL,
    location TEXT NOT NULL,
    required_education TEXT NOT NULL, -- Stored as a JSON array string
    required_skills TEXT NOT NULL,     -- Stored as a JSON array string
    sector TEXT NOT NULL,
    description TEXT,
    stipend TEXT,
    duration TEXT,
    posted_date DATE,
    apply_link TEXT
);

-- Insert sample internship data with more details
-- Note: Dates are in YYYY-MM-DD format for today, Sept 6, 2025.
INSERT INTO internships (title, company, location, required_education, required_skills, sector, description, stipend, duration, posted_date, apply_link) VALUES
('Data Entry Operator', 'Govt. Services Inc.', 'Delhi', '["12th Pass", "Diploma", "Graduate"]', '["Computer Basics", "Typing"]', 'Government', 'Responsible for entering data from various sources into the company database and ensuring the accuracy and completeness of the information.', '₹12,000/month', '6 Months', '2025-09-01', '#apply'),
('Agriculture Field Assistant', 'Krishi Vikas Kendra', 'Rural', '["10th Pass", "12th Pass"]', '["Field Work"]', 'Agriculture', 'Assist senior staff in field activities, including soil testing, crop monitoring, and data collection. Must be willing to travel to local farms.', '₹8,000/month', '3 Months', '2025-09-05', '#apply'),
('Community Health Worker', 'Swasthya Mission', 'Rural', '["10th Pass", "12th Pass"]', '["Communication"]', 'Healthcare', 'Work with local communities to spread awareness about health programs, conduct basic health check-ups, and assist in organizing health camps.', 'Unpaid (Certificate & Travel Allowance Provided)', '4 Months', '2025-08-28', '#apply'),
('Junior Web Developer', 'Tech Startup Hub', 'Bangalore', '["Diploma", "Graduate"]', '["HTML & CSS", "JavaScript"]', 'IT', 'Join our dynamic tech team to assist in the development and maintenance of our web applications. A great opportunity to learn from experienced developers.', '₹18,000/month', '6 Months', '2025-09-02', '#apply'),
('Social Media Assistant', 'Digital India Foundation', 'Mumbai', '["12th Pass", "Graduate"]', '["Social Media", "Content Creation"]', 'IT', 'Manage and create content for our social media channels, engage with our online community, and help plan digital marketing campaigns.', '₹10,000/month', '3 Months', '2025-08-30', '#apply'),
('Customer Support Executive', 'Bharat Connect', 'Pune', '["12th Pass", "Graduate"]', '["Communication"]', 'Customer Service', 'Provide solutions to customer queries via phone and email. Must have excellent communication skills and a patient, professional demeanor.', '₹15,000/month', '6 Months', '2025-09-04', '#apply'),
('Graphic Design Intern', 'Creative Designs Co.', 'Bangalore', '["Diploma", "Graduate"]', '["Graphic Design"]', 'Design', 'Work on a variety of design projects, including social media posts, website banners, and marketing materials. Proficiency in design software is a must.', '₹12,000/month', '3 Months', '2025-08-25', '#apply'),
('Panchayat Office Assistant', 'Local Governance Body', 'Rural', '["12th Pass"]', '["Computer Basics", "Communication"]', 'Government', 'Assist in day-to-day administrative tasks at the local Panchayat office, including file management and public grievance redressal.', '₹7,500/month', '6 Months', '2025-09-01', '#apply'),
('Solar Panel Technician Trainee', 'Green Energy Solutions', 'Jaipur', '["10th Pass", "Diploma"]', '["Technical Skills"]', 'Energy', 'A hands-on training program to learn the installation and maintenance of solar panels for residential and commercial projects.', '₹9,000/month', '4 Months', '2025-08-29', '#apply'),
('Hospital Front Desk Coordinator', 'City General Hospital', 'Delhi', '["12th Pass", "Graduate"]', '["Communication", "Computer Basics"]', 'Healthcare', 'Manage patient appointments, handle inquiries, and ensure a smooth functioning of the front desk. A compassionate attitude is required.', '₹14,000/month', '6 Months', '2025-09-05', '#apply');

