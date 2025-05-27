
      function addProject() {
    const container = document.getElementById("project-container");
    const newRow = document.createElement("div");
    newRow.classList.add("row", "project-row");

    // Create new project fields with a delete button
    newRow.innerHTML = `
        <div class="group">
            <input required type="text" class="input" name="projectTitle"/>
            <span class="highlight"></span> 
            <span class="bar"></span>
            <label>Project Name</label>
        </div>
        <div class="group">
        <input required type="text" class="input" name="techUsed"/>
        <span class="highlight"></span>
        <span class="bar"></span>
        <label>Technology used  </label>
      </div>
        <div class="group">
            <input required type="text" class="input" name="projectDescription"/>
            <span class="highlight"></span>
            <span class="bar"></span>
            <label>Project Description</label>
        </div>
        <button type="button" class="remove-btn" onclick="removeProject(this)">Remove Project</button>
    `;
    
    container.appendChild(newRow);
}

// Function to remove a project field
function removeProject(button) {
    const projectRow = button.parentElement;
    projectRow.remove();
}
function togglePassword(fieldId, icon) {
  const input = document.getElementById(fieldId);
  if (input.type === "password") {
    input.type = "text";
    icon.textContent = "🙈";
  } else {
    input.type = "password";
    icon.textContent = "👁️";
  }
}

function validatePasswords() {
  const password = document.getElementById("password").value;
  const confirmPassword = document.getElementById("confirmPassword").value;
  const errorDiv = document.getElementById("passwordError");

  if (password !== confirmPassword) {
    errorDiv.textContent = "Passwords do not match!";
    return false; // Prevent form submission
  }

  errorDiv.textContent = ""; // Clear error if match
  return true; // Allow form submission
}

document.getElementById("myForm").addEventListener("submit", function(e) {
      const imageFile = document.getElementById("image").files[0];
      const pdfFile = document.getElementById("pdf").files[0];
      const message = document.getElementById("message");

      // Check image file
      if (imageFile) {
        const imageSizeKB = imageFile.size / 1024;
        if (imageFile.type !== "image/jpeg") {
          e.preventDefault();
          message.textContent = "Only .jpg images are allowed.";
          return;
        }
        if (imageSizeKB > 200) {
          e.preventDefault();
          message.textContent = "Image must be less than or equal to 200KB.";
          return;
        }
      }

      // Check PDF file
      if (pdfFile) {
        const pdfSizeKB = pdfFile.size / 1024;
        if (pdfFile.type !== "application/pdf") {
          e.preventDefault();
          message.textContent = "Only .pdf files are allowed.";
          return;
        }
        if (pdfSizeKB > 100) {
          e.preventDefault();
          message.textContent = "PDF must be less than or equal to 100KB.";
          return;
        }
      }

      message.textContent = ""; // Clear error if all good
    });
	console.log("Registration.js file uploaded")