<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Qacha 's High School - Student List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        #body{
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f0f2f5; /* Light grey background */
            display: flex;
            justify-content: center; /* Center the table horizontally */
            align-items: flex-start; /* Align table to the top */
            min-height: 100vh; /* Ensure body takes full viewport height */
            padding: 20px; /* Adjusted padding for overall layout */
            box-sizing: border-box; /* Include padding in body's total width/height */
        }

        .table-container {
            width: 100%; /* Make it take full width of its parent flex item */
            max-width: 1200px; /* Max width to prevent it from getting too wide on large screens */
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow-x: auto; /* Enable horizontal scrolling for smaller screens */
        }

        table {
            width: 100%;
            border-collapse: collapse; /* Remove space between cell borders */
            text-align: left;
            /* white-space: nowrap; // Keep this if you prefer horizontal scroll over text wrapping for all cells */
        }

        table thead {
            background-color: #f8f9fa; /* Light grey for table header background */
            color: #333;
            font-size: 14px;
        }

        table th {
            padding: 12px 15px;
            border-bottom: 1px solid #dee2e6; /* Border below header cells */
            text-transform: uppercase; /* Uppercase header text */
            font-weight: bold;
        }

        table tbody tr {
            border-bottom: 1px solid #e9ecef; /* Light border between rows */
        }

        table tbody tr:nth-child(even) {
            background-color: #fcfcfc; /* Slightly different background for even rows */
        }

        table tbody tr:hover {
            background-color: #f2f2f2; /* Subtle hover effect */
        }

        table td {
            padding: 12px 15px;
            font-size: 14px;
            color: #555;
            vertical-align: middle; /* Align content in middle of cell */
            word-wrap: break-word; /* Allow long words to break */
            overflow-wrap: break-word; /* Standard property */
        }

        /* Specific styling for the 'Status' column */
        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px; /* Pill shape */
            font-weight: bold;
            font-size: 12px;
            text-align: center;
            min-width: 60px; /* Ensure badge has a minimum width */
        }

        .status-active {
            background-color: #d4edda; /* Light green background */
            color: #155724; /* Dark green text */
        }

        .status-inactive {
            background-color: #f8d7da; /* Light red background */
            color: #721c24; /* Dark red text */
        }

        /* Styling for Action icons */
        .action-icons {
            display: flex; /* Arrange icons in a row */
            gap: 10px; /* Space between icons */
        }

        .action-icons i {
            /* No cursor or color here, as the <a> tag will handle it */
            font-size: 16px;
            transition: color 0.2s ease;
        }

        .action-icons a { /* Styling for the links around icons */
            color: #6c757d; /* Default color for all icons */
            text-decoration: none; /* Remove underline */
            display: inline-flex; /* To ensure padding/margin works consistently */
            align-items: center; /* Vertically center icon inside link */
            justify-content: center;
        }

        .action-icons a:hover {
            color: #0056b3; /* A general hover color for action links */
        }

        .action-icons a .fa-eye { /* View icon */
            color: #6c757d; /* Grey */
        }

        .action-icons a:hover .fa-eye {
            color: #5a6268;
        }

        .action-icons a .fa-trash-alt { /* Delete icon */
            color: #dc3545; /* Red */
        }

        .action-icons a:hover .fa-trash-alt {
            color: #c82333;
        }

        .action-icons a .fa-edit { /* Edit icon */
            color: #007bff; /* Blue */
        }

        .action-icons a:hover .fa-edit {
            color: #0056b3;
        }


        /* --- Media Queries for Responsiveness --- */

        /* For screens smaller than 992px (common tablet landscape / small desktop) */
        @media (max-width: 992px) {
            table th, table td {
                padding: 10px 12px; /* Slightly reduce padding */
                font-size: 13px; /* Slightly reduce font size */
            }
        }

        /* For screens smaller than 768px (common tablet portrait / large phone) */
        @media (max-width: 768px) {
            body {
                padding: 15px; /* Reduce overall padding */
            }

            table thead {
                font-size: 13px;
            }

            table th, table td {
                padding: 8px 10px; /* Further reduce padding */
                font-size: 12px; /* Further reduce font size */
            }
        }

        /* For screens smaller than 480px (common mobile phones) */
        @media (max-width: 480px) {
            body {
                padding: 10px; /* Minimal overall padding */
            }

            table th, table td {
                padding: 6px 8px; /* Even smaller padding */
                font-size: 11px; /* Even smaller font size */
            }

            .status-badge {
                padding: 3px 8px;
                font-size: 10px;
                min-width: 50px;
            }

            .action-icons {
                gap: 5px; /* Reduce gap between icons */
            }
            .action-icons a i { /* Targeting icon inside the link */
                font-size: 14px; /* Slightly smaller icons */
            }
        }
    </style>
</head>
<body id='body'>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>SNo.</th>
                    <th>Student Name</th>
                    <th>Session Name</th>
                    <th>Gender</th>
                    <th>DOB</th>
                    <th>Class</th>
                    <th>Section</th>
                    <th>Guardian Name</th>
                    <th>Guardian Email Address</th>
                    <th>Guardian Mobile No</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%-- Sample Hardcoded Student Data (Replace with dynamic data from DB in real app) --%>
                <%
                    // In a real application, you'd fetch a List<Student> from a database
                    // For demonstration, we'll manually define some students
                    // Using a simple array of arrays for demo purposes
                    String[][] students = {
                        {"1", "Rakesh Kumar", "2023-2024", "Male", "26/08/2005", "12th", "A", "KL Kumar", "kumar.kl@gmail.com", "+91 9876543210", "Active"},
                        {"2", "Priya Gosh", "2023-2024", "Female", "01/12/2006", "12th", "A", "Suman Gosh", "goshsuman09@gmail.com", "+91 8745671235", "Inactive"},
                        {"3", "Shivam Das", "2023-2024", "Male", "12/04/2005", "12th", "A", "Krishna Das", "daskrish12@gmail.com", "+91 8567312908", "Active"},
                        {"4", "Rohit Sharma", "2023-2024", "Male", "01/10/2006", "12th", "A", "NP Sharma", "k.sharma89@gmail.com", "+91 7654128907", "Inactive"},
                        {"5", "Payal Negi", "2023-2024", "Female", "11/09/2006", "12th", "A", "RK Negi", "negirk@gmail.com", "+91 893456710", "Active"},
                        {"6", "Honey Bhati", "2023-2024", "Male", "01/01/2006", "12th", "A", "Prem Bhati", "prembhati@gmail.com", "+91 89345671890", "Inactive"},
                        {"7", "Komal Pandey", "2023-2024", "Female", "04/05/2006", "12th", "A", "Shrey Pandey", "shrey67pandey@gmail.com", "+91 7854389012", "Inactive"},
                        {"8", "Bhavna", "2023-2024", "Female", "13/02/2006", "12th", "A", "Ravi Singh", "singhravi@gmail.com", "+91 7865431290", "Inactive"},
                        {"9", "Ajay Puri", "2023-2024", "Male", "11/05/2005", "12th", "A", "Vikas Puri", "vk1985@gmail.com", "+91 8759390872", "Active"},
                        {"10", "Vijay Gupta", "2023-2024", "Male", "10/08/2006", "12th", "A", "Vinay Gupta", "guptavinay@gmail.com", "+91 6789124567", "Inactive"}
                    };

                    for (String[] student : students) {
                        String sno = student[0];
                        String studentName = student[1];
                        String sessionName = student[2];
                        String gender = student[3];
                        String dob = student[4];
                        String studentClass = student[5];
                        String section = student[6];
                        String guardianName = student[7];
                        String guardianEmail = student[8];
                        String guardianMobile = student[9];
                        String status = student[10];

                        // Construct the URL for the view_student.jsp page with all parameters
                        String viewUrl = "student_view.jsp?" +
                                "sno=" + sno +
                                "&studentName=" + java.net.URLEncoder.encode(studentName, "UTF-8") +
                                "&sessionName=" + java.net.URLEncoder.encode(sessionName, "UTF-8") +
                                "&gender=" + java.net.URLEncoder.encode(gender, "UTF-8") +
                                "&dob=" + java.net.URLEncoder.encode(dob, "UTF-8") +
                                "&studentClass=" + java.net.URLEncoder.encode(studentClass, "UTF-8") +
                                "&section=" + java.net.URLEncoder.encode(section, "UTF-8") +
                                "&guardianName=" + java.net.URLEncoder.encode(guardianName, "UTF-8") +
                                "&guardianEmail=" + java.net.URLEncoder.encode(guardianEmail, "UTF-8") +
                                "&guardianMobile=" + java.net.URLEncoder.encode(guardianMobile, "UTF-8") +
                                "&status=" + java.net.URLEncoder.encode(status, "UTF-8");
                %>
                <tr>
                    <td><%= sno %></td>
                    <td><%= studentName %></td>
                    <td><%= sessionName %></td>
                    <td><%= gender %></td>
                    <td><%= dob %></td>
                    <td><%= studentClass %></td>
                    <td><%= section %></td>
                    <td><%= guardianName %></td>
                    <td><%= guardianEmail %></td>
                    <td><%= guardianMobile %></td>
                    <td><span class="status-badge <%= "Active".equals(status) ? "status-active" : "status-inactive" %>"><%= status %></span></td>
                    <td class="action-icons">
                        <%-- View and Delete icons are now wrapped in simple links --%>
                        <a href="<%= viewUrl %>" title="View"><i class="fas fa-eye"></i></a>
                        <a href="#" title="Delete" onclick="return confirm('Are you sure you want to delete <%= studentName %>?');"><i class="fas fa-trash-alt"></i></a>
                        <%-- The Edit icon links to the view_student.jsp page with all student data --%>
                        <a href="<%= viewUrl %>" title="Edit"><i class="fas fa-edit"></i></a>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>