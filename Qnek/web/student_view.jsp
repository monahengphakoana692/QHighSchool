<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%-- JSTL Core Tag Library for EL --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduSync High School - View Student</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* CSS specific to this 'View Student' page */
        #body_student { /* Unique ID for the body of this page */
            font-family: Arial, sans-serif;
            margin: 0;
            display: flex; /* Use flexbox for sidebar and main content layout */
            height: 100vh; /* Full viewport height */
            background-color: #f0f2f5; /* Light grey background */
            overflow: hidden; /* Prevent overall scrollbars unless content demands it */
        }

        /* Sidebar styles */
        .sidebar_student { /* Unique class */
            width: 250px;
            background-color: #1a237e; /* Dark blue */
            color: white;
            padding: 20px 0;
            display: flex;
            flex-direction: column; /* Stack header, ul, and footer */
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
            flex-shrink: 0; /* Prevent sidebar from shrinking */
        }

        .sidebar-header_student { /* Unique class */
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: bold;
        }

        .sidebar_student ul { /* Targeting ul within unique sidebar */
            list-style: none; /* Remove bullet points */
            padding: 0;
            margin: 0;
            flex-grow: 1; /* Allow the list to take available vertical space */
        }

        .sidebar_student ul li { /* Targeting li within unique sidebar */
            margin-bottom: 10px;
        }

        .sidebar_student ul li a { /* Targeting a within unique sidebar */
            color: white;
            text-decoration: none;
            padding: 12px 20px; /* Padding for links */
            display: flex; /* Use flexbox to align icon and text */
            align-items: center; /* Vertically center icon and text */
            transition: background-color 0.3s ease; /* Smooth hover effect */
        }

        .sidebar_student ul li a i { /* Targeting i within unique sidebar link */
            margin-right: 15px; /* Space between icon and text */
            font-size: 20px;
        }

        .sidebar_student ul li a:hover,
        .sidebar_student ul li a.active { /* Targeting hover/active within unique sidebar link */
            background-color: #0d47a1; /* Slightly lighter blue on hover/active */
            border-left: 5px solid #ffeb3b; /* Yellow accent on active */
        }

        .sidebar-footer_student { /* Unique class */
            padding: 20px;
            text-align: center;
            font-size: 14px;
            border-top: 1px solid rgba(255, 255, 255, 0.1); /* Subtle white border */
        }

        .sidebar-footer_student i { /* Targeting i within unique sidebar footer */
            margin: 0 5px; /* Space between footer icons */
        }

        /* Main content area */
        .main-content_student { /* Unique class */
            flex-grow: 1; /* Allows main content to take remaining space */
            padding: 20px;
            display: flex;
            flex-direction: column; /* Stack back button, header and card vertically */
            overflow-y: auto; /* Allow vertical scrolling if content overflows */
        }

        /* Header within main content */
        .header_student { /* Unique class */
            display: flex;
            justify-content: space-between; /* Push title to left, logout to right */
            align-items: center; /* Vertically center items */
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ccc; /* Separator line */
        }

        .header_student h1 { /* Targeting h1 within unique header */
            margin: 0;
            font-size: 28px;
            color: #333;
        }

        .header_student .logout_student a { /* Targeting a within unique logout */
            color: #d32f2f; /* Red logout text */
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
        }

        /* Card containing the form */
        .card_student { /* Unique class */
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            padding: 30px;
            flex-grow: 1; /* Allow card to take available height */
        }

        /* Form group for labels and inputs */
        .form-group_student { /* Unique class */
            margin-bottom: 20px;
        }

        .form-group_student label { /* Targeting label within unique form group */
            display: block; /* Make label appear on its own line */
            font-weight: bold;
            margin-bottom: 8px;
            color: #555;
        }

        .form-group_student input[type="text"],
        .form-group_student select { /* Targeting inputs/select within unique form group */
            width: 100%; /* Full width within its container */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box; /* Include padding and border in the element's total width */
        }

        /* Custom styling for select dropdown arrow */
        .form-group_student select { /* Targeting select within unique form group */
            appearance: none; /* Remove default arrow in some browsers */
            -webkit-appearance: none;
            background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http://www.w3.org/2000/svg%22%20viewBox%3D%220%200%204%205%22%3E%3Cpath%20fill%3D%22%23333%22%20d%3D%22M2%200L0%202h4L2%200z%22/%3E%3C/svg%3E'); /* Custom SVG arrow */
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 10px;
            padding-right: 30px; /* Space for the custom arrow */
        }

        /* Button group layout */
        .button-group_student { /* Unique class */
            margin-top: 30px;
            display: flex; /* Use flexbox for buttons */
            flex-wrap: wrap; /* Allow buttons to wrap on smaller screens */
            justify-content: flex-start; /* Align buttons to the left by default */
            gap: 15px; /* Space between buttons */
        }

        .button-group_student button { /* Targeting buttons within unique button group */
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            color: white;
            font-weight: bold;
            flex-grow: 1; /* Allow buttons to grow and fill space */
            min-width: 150px; /* Minimum width for buttons */
        }

        .button-group_student .btn-gradebook_student { /* Unique class */
            background-color: #28a745; /* Green */
        }

        .button-group_student .btn-gradebook_student:hover { /* Unique class */
            background-color: #218838;
        }

        .button-group_student .btn-update_student { /* Unique class */
            background-color: #007bff; /* Blue */
        }

        .button-group_student .btn-update_student:hover { /* Unique class */
            background-color: #0056b3;
        }

        .button-group_student .btn-transactions_student { /* Unique class */
            background-color: #17a2b8; /* Cyan/Teal */
        }

        .button-group_student .btn-transactions_student:hover { /* Unique class */
            background-color: #138496;
        }

        .button-group_student .btn-delete_student { /* Unique class */
            background-color: #dc3545; /* Red */
            margin-left: auto; /* Pushes the delete button to the far right */
        }

        .button-group_student .btn-delete_student:hover { /* Unique class */
            background-color: #c82333;
        }

        /* Styles for the new Back button */
        .back-button-container_student { /* Unique class */
            margin-bottom: 20px; /* Space below the back button */
            display: flex; /* Use flex to align link */
            align-items: center;
        }

        .back-button_student { /* Unique class */
            text-decoration: none;
            color: #1a237e; /* Dark blue, matching sidebar header color */
            font-weight: bold;
            font-size: 16px;
            padding: 8px 15px;
            border: 1px solid #1a237e;
            border-radius: 5px;
            transition: all 0.3s ease;
            display: inline-flex; /* Allows icon and text to be on one line */
            align-items: center;
            background-color: #e3f2fd; /* Light blue background */
        }

        .back-button_student i { /* Targeting i within unique back button */
            margin-right: 8px;
            font-size: 18px;
        }

        .back-button_student:hover { /* Unique class */
            background-color: #bbdefb; /* Lighter blue on hover */
            color: #1a237e;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        /* Responsive adjustments for the back button */
        @media (max-width: 768px) {
            .main-content_student { /* Unique class */
                padding-top: 20px; /* Adjust padding if fixed header is used on smaller screens */
            }
            .back-button-container_student { /* Unique class */
                padding: 0 15px; /* Add horizontal padding for smaller screens if main-content has less */
            }
            .back-button_student { /* Unique class */
                width: auto; /* Allow button to size naturally */
                font-size: 14px;
                padding: 10px 15px;
            }
        }
    </style>
</head>
<body id='body_student'>

    <div class="sidebar_student">
        <div class="sidebar-header_student">
            Qacha 's nek High School
        </div>
        <ul>
            <li><a href="#" class="active_student"><i class="fas fa-th-large"></i> Main Dashboard</a></li>
            <li><a href="#"><i class="fas fa-chalkboard-teacher"></i> Teachers</a></li>
            <li><a href="#"><i class="fas fa-users"></i> Students</a></li>
            <li><a href="#"><i class="fas fa-book"></i> Subjects</a></li>
            <li><a href="#"><i class="fas fa-calendar-alt"></i> Calendar</a></li>
            <li><a href="#"><i class="fas fa-clock"></i> Timetable</a></li>
            <li><a href="#"><i class="fas fa-file-invoice"></i> Accounts</a></li>
            <li><a href="#"><i class="fas fa-boxes"></i> Inventory</a></li>
            <li><a href="#"><i class="fas fa-book-reader"></i> Library</a></li>
        </ul>
        <div class="sidebar-footer_student">
            Qacha 's nek high Support<br>
            <i class="fas fa-envelope"></i><i class="fas fa-phone"></i>
        </div>
    </div>

    <div class="main-content_student">
        <div class="back-button-container_student">
            <a href="index.jsp" class="back-button_student">
                <i class="fas fa-arrow-left"></i> main
            </a>
        </div>

        <div class="header_student">
            <%-- Display the student name in the header, default to "Unknown Student" --%>
            <h1>View Student: ${param.studentName != null ? param.studentName : 'Unknown Student'}</h1>
            <div class="logout_student">
                <a href="#">Logout</a>
            </div>
        </div>

        <div class="card_student">
            <%-- In a real application, the form action would point to a servlet or another JSP for processing --%>
            <form action="#" method="post">
                <div class="form-group_student">
                    <label for="sno">SNo.</label>
                    <%-- Using EL to populate the value and handle nulls --%>
                    <input type="text" id="sno" name="sno" value="${param.sno != null ? param.sno : 'N/A'}" readonly>
                </div>
                <div class="form-group_student">
                    <label for="studentName">Student Name</label>
                    <input type="text" id="studentName" name="studentName" value="${param.studentName != null ? param.studentName : ''}">
                </div>
                <div class="form-group_student">
                    <label for="sessionName">Session Name</label>
                    <input type="text" id="sessionName" name="sessionName" value="${param.sessionName != null ? param.sessionName : ''}">
                </div>
                <div class="form-group_student">
                    <label for="gender">Gender</label>
                    <select id="gender" name="gender">
                        <%-- Using EL for conditional 'selected' attribute --%>
                        <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                        <option value="Other" ${param.gender == 'Other' ? 'selected' : ''}>Other</option>
                    </select>
                </div>
                <div class="form-group_student">
                    <label for="dob">Date of Birth</label>
                    <input type="text" id="dob" name="dob" value="${param.dob != null ? param.dob : ''}">
                </div>
                <div class="form-group_student">
                    <label for="studentClass">Class</label>
                    <input type="text" id="studentClass" name="studentClass" value="${param.studentClass != null ? param.studentClass : ''}">
                </div>
                <div class="form-group_student">
                    <label for="section">Section</label>
                    <input type="text" id="section" name="section" value="${param.section != null ? param.section : ''}">
                </div>

                <%-- Guardian Fields --%>
                <div class="form-group_student">
                    <label for="guardianName">Guardian Name</label>
                    <input type="text" id="guardianName" name="guardianName" value="${param.guardianName != null ? param.guardianName : ''}">
                </div>
                <div class="form-group_student">
                    <label for="guardianFirstName">Guardian First Name</label>
                    <input type="text" id="guardianFirstName" name="guardianFirstName" value="${param.guardianFirstName != null ? param.guardianFirstName : ''}">
                </div>
                <div class="form-group_student">
                    <label for="guardianLastName">Guardian Last Name</label>
                    <input type="text" id="guardianLastName" name="guardianLastName" value="${param.guardianLastName != null ? param.guardianLastName : ''}">
                </div>
                <div class="form-group_student">
                    <label for="guardianGender">Guardian Gender</label>
                    <select id="guardianGender" name="guardianGender">
                        <option value="Male" ${param.guardianGender == 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${param.guardianGender == 'Female' ? 'selected' : ''}>Female</option>
                        <option value="Other" ${param.guardianGender == 'Other' ? 'selected' : ''}>Other</option>
                    </select>
                </div>
                <div class="form-group_student">
                    <label for="guardianContactInfo">Guardian Contact Information</label>
                    <input type="text" id="guardianContactInfo" name="guardianContactInfo" value="${param.guardianContactInfo != null ? param.guardianContactInfo : ''}">
                </div>
                <div class="form-group_student">
                    <label for="guardianAddress">Guardian Address</label>
                    <input type="text" id="guardianAddress" name="guardianAddress" value="${param.guardianAddress != null ? param.guardianAddress : ''}">
                </div>
                <div class="form-group_student">
                    <label for="guardianEmail">Guardian Email Address</label>
                    <input type="text" id="guardianEmail" name="guardianEmail" value="${param.guardianEmail != null ? param.guardianEmail : ''}">
                </div>
                <div class="form-group_student">
                    <label for="guardianMobile">Guardian Mobile No</label>
                    <input type="text" id="guardianMobile" name="guardianMobile" value="${param.guardianMobile != null ? param.guardianMobile : ''}">
                </div>
                <div class="form-group_student">
                    <label for="status">Status</label>
                    <select id="status" name="status">
                        <option value="Active" ${param.status == 'Active' ? 'selected' : ''}>Active</option>
                        <option value="Inactive" ${param.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>

                <div class="button-group_student">
                    <button type="submit" class="btn-gradebook_student">View Gradebook</button>
                    <button type="submit" class="btn-update_student">Update</button>
                    <button type="submit" class="btn-transactions_student">Transactions</button>
                    <button type="submit" class="btn-delete_student">Delete</button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>