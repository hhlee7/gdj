import { useState } from "react";
import { useNavigate } from "react-router-dom";

export default function AddCountry() {
    // let country = "";

    // 상태 변수로 만들기
    const [country, setCountry] = useState("");
    const navigate = useNavigate();

    function addFetch() {
        // alert('addCountry');
        fetch("http://localhost/country", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({country: country})
        })
        .then((res) => {
            if(res.ok) { // http 상태 코드 : 200
                alert("입력 성공");
                // /Country 컴포넌트를 렌더링
                navigate("/Country"); // <Link to="/Country" />
            } else { // 300, 400, 500
                alert("입력 실패");
            }
        })
    }

    return (
        <div className="flex flex-col items-center mt-6">
            <h1 className="text-2xl font-bold mb-4">
                AddCountry
            </h1>
            <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Country</label>
                <input
                    type="text"
                    className="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                    onChange={(e) => {
                    // country = e.target.value;
                    setCountry(e.target.value);
                }}/>
            </div>
            <button onClick={addFetch} className="mt-4 px-4 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition">입력</button>
        </div>
    )
}
