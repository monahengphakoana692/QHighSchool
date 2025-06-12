<%@page import="com.qacha.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<%
User user = (User) session.getAttribute("user");
if (user == null || !"teacher".equals(user.getRole())) {
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Qacha High School - Dashboard</title>
    <%-- Font Awesome for Icons --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* General Body and Layout */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* Modern font */
            margin: 0;
            display: flex;
            flex-direction: row; /* Default for larger screens */
            height: 100vh;
            background-color: #f0f2f5; /* Light grey background */
            overflow-x: hidden; /* Prevent horizontal scroll */
        }

        /* Sidebar Styles (Desktop First) */
        .sidebar {
            width: 250px;
            min-width: 250px; /* Ensures sidebar doesn't shrink */
            background-color: #1a237e; /* Dark blue - Primary */
            color: white;
            padding: 20px 0;
            display: flex;
            flex-direction: column;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            transition: transform 0.3s ease-in-out; /* Smooth slide transition for mobile */
        }

        .sidebar-header {
            text-align: center;
            margin-bottom: 30px;
            font-size: 20px; /* Slightly larger */
            font-weight: bold;
            padding: 0 20px;
            color: white; /* Yellow accent for school name */
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
            flex-grow: 1; /* Allows the ul to take available space */
        }

        .sidebar ul li {
            margin-bottom: 5px; /* Slightly reduced margin */
        }

        .sidebar ul li a {
            color: white;
            text-decoration: none;
            padding: 12px 20px;
            display: flex; /* For icon and text alignment */
            align-items: center;
            transition: background-color 0.3s ease, border-left 0.3s ease, color 0.3s ease;
        }

        .sidebar ul li a i {
            margin-right: 15px;
            font-size: 18px; /* Slightly smaller icons */
            color: rgba(255, 255, 255, 0.8); /* Dimmed icon color */
        }

        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            background-color: #0d47a1; /* Slightly lighter blue on hover/active */
            border-left: 5px solid #ffeb3b; /* Yellow accent for active link */
            color: #ffeb3b; /* Highlight text color */
        }

        .sidebar ul li a:hover i,
        .sidebar ul li a.active i {
            color: #ffeb3b; /* Highlight icon color */
        }

        .sidebar-footer {
            padding: 20px;
            text-align: center;
            font-size: 13px; /* Slightly smaller */
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.7); /* Slightly dimmed color */
        }

        .sidebar-footer i {
            margin: 0 5px;
            color: #ffeb3b; /* Yellow icons for emphasis */
            font-size: 16px;
        }

        /* Main Content Area */
        .main-content {
            flex-grow: 1; /* Takes remaining horizontal space */
            padding: 20px;
            display: flex;
            flex-direction: column; /* Stacks header and dynamic content vertically */
            background-color: #f0f2f5; /* Match body background */
        }

        /* Header Styles */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px 20px; /* Adjusted padding */
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            flex-shrink: 0; /* Prevents header from shrinking */
            position: sticky; /* Make header sticky */
            top: 0;
            z-index: 99; /* Ensure it stays above content */
            border-bottom: none; /* Removed redundant border */
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
            color: #333;
            flex-grow: 1; /* Allow title to take space */
            text-align: center; /* Center title by default */
        }

        .header .logout {
            margin-left: 20px; /* Space between title and logout */
        }

        .header .logout a {
            color: #d32f2f; /* Red for logout */
            text-decoration: none;
            font-weight: bold;
            font-size: 15px; /* Slightly larger */
            padding: 8px 12px;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .header .logout a:hover {
            color: #ff1744; /* Brighter red on hover */
            background-color: #fbe9e7; /* Light red background on hover */
        }

        /* Hamburger Icon (Mobile Only) */
        .hamburger-menu {
            display: none; /* Hidden by default on large screens */
            font-size: 28px;
            color: #333;
            cursor: pointer;
            padding: 5px;
            margin-right: 15px; /* Space from title */
            order: -1; /* Place before h1 in flex order */
        }

        /* Dynamic Content Card (Where AJAX content loads) */
        .dynamic-content-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* Stronger shadow */
            padding: 30px;
            flex-grow: 1; /* Allows card to take remaining vertical space */
            margin-top: 20px; /* Space below header */
            overflow-x: auto; /* Horizontal scroll for wide content (e.g., tables) */
            overflow-y: auto; /* Vertical scroll for content exceeding card height */
            min-height: 0; /* Crucial for flex items with overflow */
        }

        /* General Form Element Styles (for loaded content) */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #555;
            font-size: 15px;
        }

        .form-group input[type="text"],
        .form-group select,
        .form-group input[type="email"],
        .form-group input[type="password"],
        .form-group input[type="number"], /* Added for common number inputs */
        .form-group textarea { /* Added for text areas */
            width: 100%;
            padding: 12px; /* Slightly more padding */
            border: 1px solid #ccc; /* Lighter border */
            border-radius: 6px; /* Slightly more rounded */
            font-size: 16px;
            box-sizing: border-box; /* Include padding and border in element's total width/height */
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: #007bff; /* Highlight border on focus */
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.25); /* Subtle shadow on focus */
            outline: none; /* Remove default outline */
        }

        .form-group select {
            /* Custom arrow for select dropdown */
            appearance: none;
            -webkit-appearance: none;
            background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http://www.w3.org/2000/svg%22%20viewBox%3D%220%200%204%205%22%3E%3Cpath%20fill%3D%22%23333%22%20d%3D%22M2%200L0%202h4L2%200z%22/%3E%3C/svg%3E');
            background-repeat: no-repeat;
            background-position: right 12px center; /* Adjusted position */
            background-size: 10px;
            padding-right: 30px;
        }

        /* Button Group Styles */
        .button-group {
            margin-top: 30px;
            display: flex;
            flex-wrap: wrap; /* Allows buttons to wrap */
            justify-content: flex-start;
            gap: 15px; /* Space between buttons */
        }

        .button-group button {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.1s ease, box-shadow 0.2s ease;
            color: white;
            font-weight: bold;
            flex-grow: 1; /* Allows buttons to grow */
            min-width: 120px; /* Minimum width for buttons */
            box-shadow: 0 2px 4px rgba(0,0,0,0.1); /* Subtle shadow */
        }

        .button-group button:active {
            transform: translateY(1px); /* Slight press effect */
            box-shadow: 0 1px 2px rgba(0,0,0,0.15); /* Smaller shadow on press */
        }

        .button-group .btn-gradebook {
            background-color: #28a745; /* Green */
        }
        .button-group .btn-gradebook:hover {
            background-color: #218838;
        }

        .button-group .btn-update {
            background-color: #007bff; /* Blue */
        }
        .button-group .btn-update:hover {
            background-color: #0056b3;
        }

        .button-group .btn-transactions {
            background-color: #17a2b8; /* Cyan */
        }
        .button-group .btn-transactions:hover {
            background-color: #138496;
        }

        .button-group .btn-delete {
            background-color: #dc3545; /* Red */
            margin-left: auto; /* Pushes delete button to the right for larger screens */
        }
        .button-group .btn-delete:hover {
            background-color: #c82333;
        }

        /* Overlay when sidebar is active (Mobile Only) */
        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 990; /* Below sidebar */
            transition: opacity 0.3s ease;
            opacity: 0;
        }
        .overlay.active {
            display: block;
            opacity: 1;
        }

        /* --- Media Queries for Responsiveness --- */

        /* For screens smaller than 768px (common tablet breakpoint) */
        @media (max-width: 768px) {
            body {
                flex-direction: column; /* Stack main content and header */
                position: relative; /* Needed for sidebar positioning */
            }

            .sidebar {
                position: fixed; /* Fixed position for slide-in effect */
                top: 0;
                left: 0;
                height: 100%; /* Take full height */
                width: 250px; /* Specific width for the slide-in menu */
                transform: translateX(-100%); /* Start off-screen to the left */
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.3);
                padding-top: 60px; /* Space for the header/hamburger icon */
            }

            .sidebar.active {
                transform: translateX(0); /* Slide in when active */
            }

            .sidebar-header {
                position: absolute; /* Position relative to sidebar */
                top: 15px;
                left: 20px;
                text-align: left; /* Align header text to left */
                font-size: 20px; /* Adjusted font size */
                margin-bottom: 0;
            }

            .sidebar ul {
                flex-direction: column; /* Stack menu items vertically again */
                justify-content: flex-start; /* Align menu items to start */
                padding: 0;
                margin-top: 20px; /* Space between header and first menu item */
            }

            .sidebar ul li {
                margin: 0;
                margin-bottom: 5px; /* Adjust spacing for vertical menu */
            }

            .sidebar ul li a {
                padding: 12px 20px; /* Restore padding */
                border-bottom: none; /* Remove bottom border */
                border-left: 5px solid transparent; /* Restore left border for active state */
                flex-direction: row; /* Icon and text back to row */
                font-size: 16px; /* Restore font size */
                text-align: left;
            }

            .sidebar ul li a i {
                margin-right: 15px; /* Restore margin */
                margin-bottom: 0; /* Remove bottom margin */
                font-size: 18px; /* Restore icon size */
            }

            .sidebar ul li a:hover,
            .sidebar ul li a.active {
                background-color: #0d47a1;
                border-left: 5px solid #ffeb3b; /* Restore left border */
                border-bottom: none; /* Ensure no bottom border */
            }

            .sidebar-footer {
                display: block; /* Show footer again for the slide-in menu */
                border-top: 1px solid rgba(255, 255, 255, 0.1);
            }

            .hamburger-menu {
                display: block; /* Show hamburger icon */
                order: -1; /* Place it before the h1 */
            }

            .main-content {
                padding: 15px;
                width: 100%;
                margin-left: 0; /* Ensure no left margin from sidebar */
                padding-top: 90px; /* Add padding to prevent content from going under fixed header */
            }

            .header {
                position: fixed; /* Fix header to top */
                top: 0;
                left: 0;
                width: 100%;
                background-color: white; /* Match card background */
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                padding: 15px; /* Adjusted padding for mobile */
                box-sizing: border-box; /* Include padding in width */
                z-index: 999; /* Below sidebar but above content */
                flex-direction: row; /* Keep header items in a row */
                justify-content: flex-start; /* Align to start */
                align-items: center; /* Center vertically */
                border-bottom: none; /* Remove default border */
                text-align: left; /* Align header items to left */
            }

            .header h1 {
                font-size: 24px;
                margin-bottom: 0;
                margin-left: 15px; /* Space after hamburger */
                text-align: left; /* Align title left on mobile */
            }

            .header .logout {
                margin-left: auto; /* Push logout to the right */
            }

            .dynamic-content-card {
                padding: 20px;
                /* overflow-y: auto and min-height: 0 are already applied */
            }

            .button-group {
                flex-direction: column; /* Stack buttons vertically on small screens */
                align-items: stretch; /* Stretch buttons to full width */
            }

            .button-group button {
                width: 100%;
                min-width: unset; /* Remove min-width constraint */
                margin-bottom: 10px; /* Space between stacked buttons */
            }

            .button-group .btn-delete {
                margin-left: 0; /* Remove auto margin for stacked buttons */
            }
        }

        /* For even smaller screens (e.g., phones) */
        @media (max-width: 480px) {
            .sidebar {
                width: 200px; /* Make sidebar slightly narrower on very small screens */
            }
            .sidebar-header {
                font-size: 5px;
                left: 15px;
            }

            .sidebar ul li a {
                padding: 10px 15px;
                font-size: 14px;
            }

            .sidebar ul li a i {
                font-size: 16px;
            }

            .header h1 {
                font-size: 20px;
            }

            .header .logout a {
                font-size: 12px;
            }

            .dynamic-content-card {
                padding: 15px;
            }

            .hamburger-menu {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>

    <div class="overlay" id="overlay" role="presentation" aria-hidden="true"></div>

    <aside class="sidebar" id="sidebar">
        <div class="sidebar-header">
            Qacha's nek High School
        </div>
        <nav aria-label="Main Navigation">
            <ul>
                <li><a href="#" class="active" id="mainDashboardLink" data-page-url="main_dashboard_content.jsp" data-page-title="Main Dashboard"><i class="fas fa-th-large"></i> Main Dashboard</a></li>
                <li><a href="javascript:void(0);" id="teachersLink" data-page-url="teachers_view.jsp" data-page-title="Teachers Management"><i class="fas fa-chalkboard-teacher"></i> Teachers</a></li>
                <li><a href="javascript:void(0);" id="studentsLink" data-page-url="Students_view.jsp" data-page-title="Students Management"><i class="fas fa-users"></i> Students</a></li>
                <li><a href="javascript:void(0);" id="subjectsLink" data-page-url="subjects_view.jsp" data-page-title="Subjects Management"><i class="fas fa-book"></i> Subjects</a></li>
                <li><a href="javascript:void(0);" id="calendarLink" data-page-url="calendar_view.jsp" data-page-title="Academic Calendar"><i class="fas fa-calendar-alt"></i> Calendar</a></li>
                <li><a href="javascript:void(0);" id="timetableLink" data-page-url="timetable_view.jsp" data-page-title="Timetable Management"><i class="fas fa-clock"></i> Timetable</a></li>
                <li><a href="javascript:void(0);" id="accountsLink" data-page-url="accounts_view.jsp" data-page-title="Accounts Management"><i class="fas fa-file-invoice"></i> Accounts</a></li>
                <li><a href="javascript:void(0);" id="inventoryLink" data-page-url="inventory_view.jsp" data-page-title="Inventory Management"><i class="fas fa-boxes"></i> Inventory</a></li>
                <li><a href="javascript:void(0);" id="libraryLink" data-page-url="library_view.jsp" data-page-title="Library Management"><i class="fas fa-book-reader"></i> Library</a></li>
            </ul>
        </nav>
        <div class="sidebar-footer">
            Qacha's Nek High Support<br>
            <i class="fas fa-envelope"></i> <i class="fas fa-phone"></i>
        </div>
    </aside>

    <div class="main-content">
        <header class="header">
            <i class="fas fa-bars hamburger-menu" id="hamburgerMenu" role="button" aria-controls="sidebar" aria-expanded="false" tabindex="0" aria-label="Toggle navigation menu"></i>
            <h1 id="mainContentTitle">Main Dashboard</h1>
            <div class="logout">
                <a href="logout.jsp" aria-label="Logout from the system">Logout</a> <%-- Assuming a logout.jsp --%>
            </div>
        </header>

        <main class="dynamic-content-card" id="dynamicContentArea" role="main" aria-live="polite">
            <p style="text-align: center; color: #666; padding: 20px;">Please select an option from the sidebar.</p>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // DOM Elements
            const hamburgerMenu = document.getElementById('hamburgerMenu');
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('overlay');
            const dynamicContentArea = document.getElementById('dynamicContentArea');
            const mainContentTitle = document.getElementById('mainContentTitle');
            const sidebarLinks = document.querySelectorAll('.sidebar ul li a'); // Get all sidebar links within the nav

            // Function to load content dynamically
            async function loadContent(pageUrl, title, targetLinkElement) {
                // Set loading message and update title
                dynamicContentArea.innerHTML = '<p style="text-align: center; color: #666; padding: 20px;">Loading ' + title + '...</p>';
                mainContentTitle.textContent = 'Loading...'; // Update header title immediately
                dynamicContentArea.setAttribute('aria-busy', 'true'); // Indicate loading state for accessibility

                try {
                    const response = await fetch(pageUrl);
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    const content = await response.text();
                    dynamicContentArea.innerHTML = content;
                    mainContentTitle.textContent = title; // Update the header title with actual title

                    // Update active class for sidebar links
                    sidebarLinks.forEach(link => link.classList.remove('active'));
                    if (targetLinkElement) {
                        targetLinkElement.classList.add('active');
                        // Add aria-current for accessibility (current page)
                        sidebarLinks.forEach(link => link.removeAttribute('aria-current'));
                        targetLinkElement.setAttribute('aria-current', 'page');
                    } else {
                        // Fallback: if somehow a targetLinkElement isn't passed, try to find by URL
                        const currentLink = document.querySelector(`.sidebar ul li a[data-page-url="${pageUrl}"]`);
                        if (currentLink) {
                            currentLink.classList.add('active');
                            sidebarLinks.forEach(link => link.removeAttribute('aria-current'));
                            currentLink.setAttribute('aria-current', 'page');
                        }
                    }

                } catch (error) {
                    console.error('Failed to load content:', error);
                    dynamicContentArea.innerHTML = `<p style="color: red; text-align: center; padding: 20px;">Error loading content: ${error.message}. Please try again.</p>`;
                    mainContentTitle.textContent = 'Error';
                } finally {
                    dynamicContentArea.setAttribute('aria-busy', 'false'); // End loading state
                    // Close sidebar and overlay on small screens after content loads
                    if (window.innerWidth <= 768) {
                        sidebar.classList.remove('active');
                        overlay.classList.remove('active');
                        if (hamburgerMenu) {
                            hamburgerMenu.setAttribute('aria-expanded', 'false');
                        }
                    }
                    // Scroll dynamic content card to top after loading new content
                    dynamicContentArea.scrollTop = 0;
                }
            }

            // Centralized Event Listener for Sidebar Links
            sidebarLinks.forEach(link => {
                link.addEventListener('click', function(event) {
                    event.preventDefault(); // Prevent default link behavior

                    const pageUrl = this.dataset.pageUrl; // Get URL from data-page-url attribute
                    const pageTitle = this.dataset.pageTitle; // Get title from data-page-title attribute

                    if (pageUrl && pageTitle) {
                        loadContent(pageUrl, pageTitle, this); // Pass 'this' (the clicked link element)
                    } else {
                        console.warn('Sidebar link missing data-page-url or data-page-title attributes:', this);
                    }
                });
            });

            // Initial load of content when the page first loads
            // Defaults to 'Main Dashboard' as the first active link, as suggested by the original 'active' class on the first link.
            const initialLink = document.getElementById('mainDashboardLink');
            if (initialLink) {
                loadContent(initialLink.dataset.pageUrl, initialLink.dataset.pageTitle, initialLink);
            } else {
                // Fallback if the initial link doesn't exist (should not happen with the static HTML)
                loadContent('main_dashboard_content.jsp', 'Main Dashboard', null); // Pass null for targetLinkElement
            }

            // Sidebar Toggle for small screens
            if (hamburgerMenu) {
                hamburgerMenu.addEventListener('click', function() {
                    const isActive = sidebar.classList.toggle('active');
                    overlay.classList.toggle('active');
                    // Update aria-expanded for accessibility
                    this.setAttribute('aria-expanded', isActive);
                });
            }

            // Close sidebar and overlay when clicking the overlay (outside sidebar)
            if (overlay) {
                overlay.addEventListener('click', function() {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    if (hamburgerMenu) {
                        hamburgerMenu.setAttribute('aria-expanded', 'false');
                    }
                });
            }

            // Close sidebar when pressing Escape key (for accessibility)
            document.addEventListener('keydown', function(event) {
                if (event.key === 'Escape' && sidebar.classList.contains('active')) {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    if (hamburgerMenu) {
                        hamburgerMenu.setAttribute('aria-expanded', 'false');
                    }
                }
            });
        });
    </script>

</body>
</html>