import { useEffect, useState } from "react";
import { useParams } from "react-router-dom"

export default function CustomerOne() {

    const {customerId} = useParams();
    const [customer, setCustomer] = useState({});

    useEffect(() => {
        fetch(`http://localhost/customerOne/${customerId}`)
        .then((res) => {return res.json()})
        .then((data) => {setCustomer(data)})
    }, []);

    return (
        <div className="p-6">

            <h1 className="text-2xl font-bold mb-4">
                CustomerOne
            </h1>

            <table className="table-auto border-collapse border border-gray-300 mb-4">
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">customerId</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{customer.customerId}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">firstName</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{customer.firstName}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">lastName</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{customer.lastName}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">email</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{customer.email}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">active</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{customer.active}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">storeId</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{customer.storeEntity?.storeId}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">address</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{customer.addressEntity?.address}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">city</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{customer.addressEntity?.cityEntity?.city}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">country</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{customer.addressEntity?.cityEntity?.countryEntity?.country}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">createDate</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{customer.createDate}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">lastUpdate</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{customer.lastUpdate}</td>
                </tr>
            </table>
            <button className="px-3 py-1 border rounded hover:bg-gray-100">삭제</button>
            <button className="px-3 py-1 border rounded hover:bg-gray-100">수정</button>
        </div>
    )
}
