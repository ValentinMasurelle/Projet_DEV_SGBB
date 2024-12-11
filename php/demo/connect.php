<?php
require "config.php";
// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
  die("MySqli Connection failed: " . $conn->connect_error);
}
echo "MySqli Connected successfully"."<br>";
?>