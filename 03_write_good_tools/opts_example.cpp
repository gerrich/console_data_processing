#include <boost/program_options.hpp>
namespace po = boost::program_options;
#include <iostream>

struct Options {
    std::string input;
    std::string output;
     
    Options(int argc, char* argv[]) {
        po::options_description desc("Example");
        desc.add_options()
        ("help,h", "print usage message")
        ("input,i", po::value<std::string>(&input), "pathname for input")
        ("output,o", po::value<std::string>(&output), "pathname for output")
        ;
    
        po::variables_map vm;
        po::store(po::parse_command_line(argc, argv, desc), vm);
        po::notify(vm);

        if (vm.count("help")) {  
            std::cout << desc << "\n";
        }
    }
};

int main(int argc, char** argv) {
    Options opt(argc, argv);
    std::cout << "read from: " << opt.input << std::endl;
    std::cout << "write to: " << opt.output << std::endl; 
    return 0;
}
