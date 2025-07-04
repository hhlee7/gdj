import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom"

export default function EditCustomer() {
    const {customerId} = useParams();
    const [customer, setCustomer] = useState({});
    const navigate = useNavigate();

    useEffect(() => {
            fetch(`http://localhost/customerOne/${customerId}`)
            .then((res) => {return res.json()})
            .then((data) => {setCustomer({...data,
                                            storeId: data.storeEntity?.storeId,
                                            addressId: data.addressEntity?.addressId})})
        }, []);

    const [addressList, setAddressList] = useState([]);

    useEffect(function () {
        fetch("http://localhost/addressListAll")
            .then(function (res) { return res.json(); })
            .then(function (data) {
                setAddressList(data);
            })
    }, []);

    function edit() {
        fetch("http://localhost/customer", {
            method: "PATCH",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({
                                customerId: customer.customerId,
                                firstName: customer.firstName,
                                lastName: customer.lastName,
                                email: customer.email,
                                active: customer.active,
                                storeId: customer.storeId,
                                addressId: customer.addressId
            })
        })
        .then((res) => {
            if(res.ok) {
                alert('수정 성공');
                navigate('/customerOne/' + customer.customerId);
            } else {
                alert('수정 실패');
            }
        })
    }

    return (
        <div className="flex flex-col items-center mt-6">
            <h1 className="text-2xl font-bold mb-4">
                EditCustomer (customerId: {customerId})
            </h1>
            <div className="w-72">
                <label className="block text-sm font-medium text-gray-700 mb-1">firstName</label>
                <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" value={customer.firstName}
                    onChange={(e) => setCustomer({...customer, firstName: e.target.value})}
                />
                <label className="block text-sm font-medium text-gray-700 mb-1">lastName</label>
                <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" value={customer.lastName}
                    onChange={(e) => setCustomer({...customer, lastName: e.target.value})}
                />
                <label className="block text-sm font-medium text-gray-700 mb-1">email</label>
                <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" value={customer.email}
                    onChange={(e) => setCustomer({...customer, email: e.target.value})}
                />
                <label className="block text-sm font-medium text-gray-700 mb-1">active</label>
                <select
                    value={customer.active}
                    className="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-400"
                    onChange={(e) => setCustomer({...customer, active: e.target.value})}>
                    <option value="1">1(활성)</option>
                    <option value="0">0(비활성)</option>
                </select>
                <label className="block text-sm font-medium text-gray-700 mb-1">addressId</label>
                <select
                    value={customer.addressId}
                    className="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-400"
                    onChange={(e) => setCustomer({...customer, addressId: e.target.value})}>
                    {addressList.map((c) => (
                        <option key={c.addressId} value={c.addressId}>{c.addressId}({c.address})</option>
                    ))}
                </select>
            </div>
            <button onClick={edit} className="mt-4 px-4 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition">수정</button>
        </div>
    )
}
