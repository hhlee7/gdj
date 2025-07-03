import { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom"

export default function AddressOne() {

    const {addressId} = useParams();
    const [address, setAddress] = useState({});

    useEffect(() => {
        fetch(`http://localhost/addressOne/${addressId}`)
        .then((res) => {return res.json()})
        .then((data) => {setAddress(data)})
    }, []);

    return (
        <div className="p-6">

            <h1 className="text-2xl font-bold mb-4">
                AddressOne
            </h1>

            {/* customer 입력 폼 컴포넌트로 이동 */}
            <Link className="text-blue-600 hover:underline" to={`/AddCustomer/${address.addressId}`}>add customer</Link>

            <table className="table-auto border-collapse border border-gray-300 mb-4">
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">addressId</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{address.addressId}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">address</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{address.address}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">address2</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{address.address2}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">district</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{address.district}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">postalCode</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{address.postalCode}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">phone</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{address.phone}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">city</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{address.cityEntity?.city}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">country</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{address.cityEntity?.countryEntity?.country}</td>
                </tr>
                <tr>
                    <th className="bg-gray-100 border px-4 py-2">lastUpdate</th>
                    <td className="hover:bg-gray-50 border px-4 py-2 text-center">{address.lastUpdate}</td>
                </tr>
            </table>
            <button className="px-3 py-1 border rounded hover:bg-gray-100">삭제</button>
            <button className="px-3 py-1 border rounded hover:bg-gray-100">수정</button>
        </div>
    )
}
