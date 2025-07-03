import { useState } from "react";
import { useNavigate, useParams } from "react-router-dom";

export default function AddAddress() {

    const {cityId} = useParams();
    const [address, setAddress] = useState("");
    const [address2, setAddress2] = useState("");
    const [district, setdistrict] = useState("");
    const [postalCode, setpostalCode] = useState("");
    const [phone, setphone] = useState("");
    const navigate = useNavigate();

    function addFetch() {
        fetch("http://localhost/address", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({
                address: address,
                address2: address2,
                district: district,
                postalCode: postalCode,
                phone: phone,
                cityId: cityId
            })
        })
        .then((res) => {
            if(res.ok) { // http 상태 코드 : 200
                alert("입력 성공");
                // /Address 컴포넌트를 렌더링
                navigate("/Address"); // <Link to="/Address" />
            } else { // 300, 400, 500
                alert("입력 실패");
            }
        })
    }

    return (
        <div className="p-6">
            <h1 className="text-2xl font-bold mb-4">
                AddAddress
            </h1>
            <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">address</label>
                <input type="text" className="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" onChange={(e) => {setAddress(e.target.value);}}/>

                <label className="block text-sm font-medium text-gray-700 mb-1">address2</label>
                <input type="text" className="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" onChange={(e) => {setAddress2(e.target.value);}}/>

                <label className="block text-sm font-medium text-gray-700 mb-1">district</label>
                <input type="text" className="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" onChange={(e) => {setdistrict(e.target.value);}}/>

                <label className="block text-sm font-medium text-gray-700 mb-1">postalCode</label>
                <input type="text" className="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" onChange={(e) => {setpostalCode(e.target.value);}}/>

                <label className="block text-sm font-medium text-gray-700 mb-1">phone</label>
                <input type="text" className="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" onChange={(e) => {setphone(e.target.value);}}/>
                
                <br />
                <button onClick={addFetch} className="mt-2 px-3 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition">입력</button>
            </div>
        </div>
    )
}
