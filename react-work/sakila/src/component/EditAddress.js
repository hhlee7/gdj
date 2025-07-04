import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom"

export default function EditCity() {
    const {addressId} = useParams();
    const [address, setAddress] = useState({});
    const navigate = useNavigate();

    useEffect(() => {
            fetch(`http://localhost/addressOne/${addressId}`)
            .then((res) => {return res.json()})
            .then((data) => {setAddress({...data, cityId: data.cityEntity?.cityId})})
        }, []);

    const [cityList, setCityList] = useState([]);

    useEffect(function () {
        fetch("http://localhost/cityListAll")
            .then(function (res) { return res.json(); })
            .then(function (data) {
                setCityList(data);
            })
    }, []);

    function edit() {
        fetch("http://localhost/address", {
            method: "PATCH",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({
                                addressId: address.addressId,
                                address: address.address,
                                address2: address.address2,
                                district: address.district,
                                postalCode: address.postalCode,
                                phone: address.phone,
                                cityId: address.cityId
            })
        })
        .then((res) => {
            if(res.ok) {
                alert('수정 성공');
                navigate('/addressOne/' + address.addressId);
            } else {
                alert('수정 실패');
            }
        })
    }

    return (
        <div className="flex flex-col items-center mt-6">
            <h1 className="text-2xl font-bold mb-4">
                EditAddress (addressId: {addressId})
            </h1>
            <div className="w-72">
                <label className="block text-sm font-medium text-gray-700 mb-1">address</label>
                <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" value={address.address}
                    onChange={(e) => setAddress({...address, address: e.target.value})}
                />
                <label className="block text-sm font-medium text-gray-700 mb-1">address2</label>
                <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" value={address.address2}
                    onChange={(e) => setAddress({...address, address2: e.target.value})}
                />
                <label className="block text-sm font-medium text-gray-700 mb-1">district</label>
                <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" value={address.district}
                    onChange={(e) => setAddress({...address, district: e.target.value})}
                />
                <label className="block text-sm font-medium text-gray-700 mb-1">postalCode</label>
                <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" value={address.postalCode}
                    onChange={(e) => setAddress({...address, postalCode: e.target.value})}
                />
                <label className="block text-sm font-medium text-gray-700 mb-1">phone</label>
                <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" value={address.phone}
                    onChange={(e) => setAddress({...address, phone: e.target.value})}
                />
                <label className="block text-sm font-medium text-gray-700 mb-1">cityId</label>
                <select
                    value={address.cityId}
                    className="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-400"
                    onChange={(e) => setAddress({...address, cityId: e.target.value})}>
                    {cityList.map((c) => (
                        <option key={c.cityId} value={c.cityId}>{c.cityId}({c.city})</option>
                    ))}
                </select>
            </div>
            <button onClick={edit} className="mt-4 px-4 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition">수정</button>
        </div>
    )
}
