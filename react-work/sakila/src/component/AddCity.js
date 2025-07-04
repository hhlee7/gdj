import { useState } from "react";
import { useNavigate, useParams } from "react-router-dom";

export default function AddCity() {

    const {countryId} = useParams();
    const [city, setCity] = useState("");
    const navigate = useNavigate();

    function addFetch() {
        fetch("http://localhost/city", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({
                city: city,
                countryId: countryId
            })
        })
        .then((res) => {
            if(res.ok) { // http 상태 코드 : 200
                alert("입력 성공");
                // /City 컴포넌트를 렌더링
                navigate("/City"); // <Link to="/City" />
            } else { // 300, 400, 500
                alert("입력 실패");
            }
        })
    }

    return (
        <div className="flex flex-col items-center mt-6">
            <h1 className="text-2xl font-bold mb-4">
                AddCity
            </h1>
            <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">City</label>
                <input
                    type="text"
                    className="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                    onChange={(e) => {
                    setCity(e.target.value);
                }}/>
            </div>
            <button onClick={addFetch} className="mt-4 px-4 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition">입력</button>
        </div>
    )
}
