function validateLoginForm() {
    const username = document.forms["loginForm"]["username"].value.trim();
    const password = document.forms["loginForm"]["password"].value.trim();

    if (username === "") {
        alert("Username is required.");
        return false;
    }

    if (password === "") {
        alert("Password is required.");
        return false;
    }

    if (password.length < 6) {
        alert("Password must be at least 6 characters long.");
        return false;
    }

    return true;
}