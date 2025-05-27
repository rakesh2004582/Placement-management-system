import { useState } from "react";
import axios from "axios";

const RegistrationForm = () => {
    const [user, setUser] = useState({ employeename: "", address: "", mobile: "" });
    const [isRegistered, setIsRegistered] = useState(false); // Track registration success

    const handleChange = (e) => {
        setUser({ ...user, [e.target.name]: e.target.value });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        console.log("Form Submitted", user); // Debugging line
        try {
            const response = await axios.post("http://localhost:8085/api/employee/save", user);
            console.log("User registered successfully:", response.data);
            setIsRegistered(true); // Set registration success
        } catch (error) {
            console.error("Error registering user:", error);
        }
    };

    return (
        <div>
            {!isRegistered ? (
                <form onSubmit={handleSubmit} className="space-y-4">
                    <h2>Registration Form</h2>
                    <input
                        type="text"
                        name="employeename"
                        placeholder="Enter Name"
                        value={user.employeename}
                        onChange={handleChange}
                        required
                        className="border p-2 rounded w-full"
                    />
                    <input
                        type="text"
                        name="address"
                        placeholder="Enter Address"
                        value={user.address}
                        onChange={handleChange}
                        required
                        className="border p-2 rounded w-full"
                    />
                    <input
                        type="text"
                        name="mobile"
                        placeholder="Enter Mobile Number"
                        value={user.mobile}
                        onChange={handleChange}
                        required
                        className="border p-2 rounded w-full"
                    />
                    <button type="submit" className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
                        Register
                    </button>
                </form>
            ) : (
                <div className="text-center">
                    <h2 className="text-2xl font-bold text-green-500">Thank You!</h2>
                    <p>Your registration has been successfully completed.</p>
                </div>
            )}
        </div>
    );
};

export default RegistrationForm;
