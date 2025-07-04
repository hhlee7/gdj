import { useEffect, useState } from "react";
import { Link, useNavigate, useParams } from "react-router-dom"

export default function AddressOne() {

    const {addressId} = useParams();
    const [address, setAddress] = useState({});
    const navigate = useNavigate();

    useEffect(() => {
        fetch(`http://localhost/addressOne/${addressId}`)
        .then((res) => {return res.json()})
        .then((data) => {setAddress(data)})
    }, []);

    function remove() {
        if(window.confirm('삭제하시겠습니까?')) {
            fetch(`http://localhost/address/${addressId}`, {method: 'DELETE'})
            .then((res) => {
                if(res.ok) { // http code : 200
                    navigate('/Address');
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
                AddressOne
            </h1>

            {/* customer 입력 폼 컴포넌트로 이동 */}
            <Link className="text-blue-600 hover:underline" to={`/AddCustomer/${address.addressId}`}>add customer</Link>

            <table className="table-auto border-collapse border border-gray-300 mt-4 mb-4">
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
            <div className="flex flex-row gap-2 mt-2">
                <button className="px-4 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition" onClick={() => {navigate(`/EditAddress/${addressId}`)}}>수정</button>
                <button className="px-4 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition" onClick={remove}>삭제</button>
            </div>
        </div>
    )
}
