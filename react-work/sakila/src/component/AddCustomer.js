import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";

export default function AddCustomer() {

    const [storeList, setStoreList] = useState([]);

    useEffect(function () {
        fetch("http://localhost/store")
            .then(function (res) { return res.json(); })
            .then(function (data) {
                setStoreList(data);
            })
    }, []);

    const {addressId} = useParams();
    const [firstName, setFirstName] = useState("");
    const [lastName, setLastName] = useState("");
    const [email, setEmail] = useState("");
    const [active, setActive] = useState("");
    const [storeId, setStoreId] = useState("");
    const navigate = useNavigate();

    function addFetch() {
        fetch("http://localhost/customer", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({
                firstName: firstName,
                lastName: lastName,
                email: email,
                active: active,
                addressId: addressId,
                storeId: storeId
            })
        })
        .then((res) => {
            if(res.ok) { // http 상태 코드 : 200
                alert("입력 성공");
                // /Customer 컴포넌트를 렌더링
                navigate("/Customer"); // <Link to="/Customer" />
            } else { // 300, 400, 500
                alert("입력 실패");
            }
        })
    }

    return (
        <div className="flex flex-col items-center mt-6">
            <h1 className="text-2xl font-bold mb-4">
                AddCustomer
            </h1>
            <div className="w-72">
                <label className="block text-sm font-medium text-gray-700 mb-1">firstName</label>
                <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" onChange={(e) => {setFirstName(e.target.value);}}/>

                <label className="block text-sm font-medium text-gray-700 mb-1">lastName</label>
                <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" onChange={(e) => {setLastName(e.target.value);}}/>

                <label className="block text-sm font-medium text-gray-700 mb-1">email</label>
                <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" onChange={(e) => {setEmail(e.target.value);}}/>

                <label className="block text-sm font-medium text-gray-700 mb-1">active</label>
                <select
                    value={active}
                    className="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-400"
                    onChange={(e) => setActive(e.target.value)}>
                    <option value="1">1(활성)</option>
                    <option value="0">0(비활성)</option>
                </select>

                <label className="block text-sm font-medium text-gray-700 mb-1">storeId</label>
                <select
                    value={storeId}
                    className="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-400"
                    onChange={(e) => setStoreId(e.target.value)}>
                    {storeList.map((c) => (
                        <option key={c.storeId} value={c.storeId}>{c.storeId}</option>
                    ))}
                </select>
            </div>
            <button onClick={addFetch} className="mt-4 px-4 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition">입력</button>
        </div>
    )
}
