import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom"

export default function CustomerOne() {

    const {customerId} = useParams();
    const [customer, setCustomer] = useState({});
    const navigate = useNavigate();

    useEffect(() => {
        fetch(`http://localhost/customerOne/${customerId}`)
        .then((res) => {return res.json()})
        .then((data) => {setCustomer(data)})
    }, []);

    function remove() {
        if(window.confirm('삭제하시겠습니까?')) {
            fetch(`http://localhost/customer/${customerId}`, {method: 'DELETE'})
            .then((res) => {
                if(res.ok) { // http code : 200
                    navigate('/Customer');
                } else { // http code : 400, 500
                    window.alert('삭제 실패');
                }
            })
        } else {
            alert('삭제를 취소합니다.')
        }
    }

    return (
        <div className="flex flex-col items-center mt-6">

            <h1 className="text-2xl font-bold mb-4">
                CustomerOne
            </h1>

            <table className="table-auto border-collapse border border-gray-300 mt-4 mb-4">
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
            <div className="flex flex-row gap-2 mt-2">
                <button className="px-4 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition" onClick={() => {navigate(`/EditCustomer/${customerId}`)}}>수정</button>
                <button className="px-4 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition" onClick={remove}>삭제</button>
            </div>
        </div>
    )
}
