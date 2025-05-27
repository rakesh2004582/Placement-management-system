console.log("Script uploaded on company reg")
    function validatePasswordMatch() {
      const password = document.getElementById("password").value;
      const confirmPassword = document.getElementById("confirmPassword").value;
      const errorDiv = document.getElementById("passwordError");
      

      if (password !== confirmPassword) {
        errorDiv.textContent = "Passwords do not match!";
      
      } else {
        errorDiv.textContent = "";
     
      }
    }

//	function registerUser(event) {
//	  event.preventDefault(); // Prevent form from submitting
//
//	  const password = document.getElementById("password").value;
//	  const confirmPassword = document.getElementById("confirmPassword").value;
//
//	  if (password !== confirmPassword) {
//	    document.getElementById("passwordError").textContent = "Passwords do not match!";
//	    return;
//	  }
//
//	  // Store locally (for test/demo only)
//	  const user = {
//	    company: document.getElementById("company").value,
//	    tenth: document.getElementById("tenth").value,
//	    twelfth: document.getElementById("twelfth").value,
//	    education: document.getElementById("education").value,
//	    edu_percent: document.getElementById("edu_percent").value,
//	    password: password
//	  };
//
//	  localStorage.setItem("registeredUser", JSON.stringify(user));
//	  alert("Registration successful! Redirecting to login...");
//
//	  // Optional: Redirect after success
//	  // window.location.href = "companyLogin.jsp";
//	}
